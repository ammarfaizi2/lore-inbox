Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUHEV4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUHEV4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUHEVyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:54:39 -0400
Received: from fmr12.intel.com ([134.134.136.15]:11932 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267901AbUHEVwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:52:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: IA64 bitkeeper trees
Date: Thu, 5 Aug 2004 14:50:58 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F01CB29F1@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IA64 bitkeeper trees
Thread-Index: AcR6hrq3D2ZRRgJFRjuJghroTjXA7gArISfA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Grant Grundler" <iod00d@hp.com>, "Pat Gefre" <pfg@sgi.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Aug 2004 21:51:00.0976 (UTC) FILETIME=[4C2E2700:01C47B36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
>On Wed, Aug 04, 2004 at 03:14:08PM -0500, Pat Gefre wrote:
>> We are posting this code for review before submitting for 
>>inclusion in
>> the 2.5 tree.
>
>I'm sure you really meant 2.6.
>
>> The patch set is at: ftp://oss.sgi.com/projects/sn2/sn2-update/
>> 
>> It is based off the http://lia64.bkbits.net/to-linus-2.5 tree
>
>I was previously told to not use that tree.
>It's only for linus to pull a subset of patches from.
>
>Tony, is "http://lia64.bkbits.net:8080/linux-ia64-2.56" the right
>tree to use?

Historically Bjorn and David each maintained two bitkeeper trees,
one of them "to-marcelo-2.4" and "to-linux-2.5" is/was used simply
as a repository for pushing ia64 specific changesets to be pulled
by the upstream maintainer.  The other "linux-ia64-2.4" for Bjorn
and "linux-ia64-2.5" for David is/was used to keep track of stuff
that isn't ready for the base.

During 2.5 all of the code required for ia64 to run was accepted
into Linus's tree ... so the delta between David's tree and Linus's
dropped at one point to zero.  Linus's tree has remained usable
without an ia64 patch since then.

I've set up two bitkeeper trees too:
	http://lia64.bkbits.net/to-base-2.6
is my holding area for patches that I want Linus to pull.

	http://lia64.bkbits.net/linux-ia64-2.6
will be a place for me to stash changesets that I'm not ready
to push (or for any non-ia64 specific changes that I want to
play with).  At the moment there is nothing in this tree that
isn't also queued in the to-base-2.6 tree.

Summary: For 99% of uses, you can clone a tree from Linus and
use it on ia64.  If you are sending a sequence of related patches
and know that I've taken some of them, then either of my trees
should work for you.

-Tony

