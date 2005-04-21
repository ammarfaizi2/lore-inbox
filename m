Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVDUSaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVDUSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVDUSaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:30:09 -0400
Received: from fmr16.intel.com ([192.55.52.70]:12241 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261615AbVDUSaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:30:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
Date: Thu, 21 Apr 2005 11:29:40 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0350B4AD@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
Thread-Index: AcVGnzZcfGYphCkuQEmPy1dYI+B6fwAABo8A
From: "Luck, Tony" <tony.luck@intel.com>
To: "Stan Bubrouski" <stan@ccs.neu.edu>
Cc: <davidm@hpl.hp.com>, <akpm@osdl.org>,
       "Andreas Hirstius" <Andreas.Hirstius@cern.ch>,
       "Bartlomiej ZOLNIERKIEWICZ" <Bartlomiej.Zolnierkiewicz@cern.ch>,
       "Gelato technical" <gelato-technical@gelato.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2005 18:29:42.0334 (UTC) FILETIME=[15BCE5E0:01C546A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That said, is there any plan to change how this functions in the future 
>to solve these problems?  I.e. have it not use so much diskspace and 
>thus use less bandwith.  Am I misunderstanding in assuming that after
>say 1000 commits go into the tree it could end up several megs or gigs 
>bigger?
>
>If that is the case might it not be more prudent to sort this out now?

Only a new user would have to pull the whole history ... and for most
uses it is sufficient to just pull the current top of the tree. Linus'
own tree only has a history going back to 2.6.12.-rc2 (when he started
using git).

Someday there might be a server daemon that can batch up the changes for
a "pull" to conserve network bandwidth.

There is a mailing list "git@vger.kernel.org" where these issues are
discussed.  Archives are available at marc.theaimsgroup.com and gelato.

-Tony
