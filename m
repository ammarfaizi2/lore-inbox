Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVKPQKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVKPQKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVKPQKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:10:53 -0500
Received: from fmr17.intel.com ([134.134.136.16]:59053 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030391AbVKPQKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:10:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] [RFC] userland swsusp
Date: Wed, 16 Nov 2005 08:10:19 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [RFC] userland swsusp
thread-index: AcXqi93ikdC1ETTfSbOI6MTjNEXM6QAO28KQ
From: "Gross, Mark" <mark.gross@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Dave Jones" <davej@redhat.com>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       "Linux-pm mailing list" <linux-pm@lists.osdl.org>
X-OriginalArrivalTime: 16 Nov 2005 16:10:21.0893 (UTC) FILETIME=[3EDC9750:01C5EAC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I worry that this is just adding more thrash to a historically unstable
implementation.  How long do we users have to wait for a swsusp
implementation where we don't have to worry about breaking from one
kernel release to the next?

I agree with this post http://lkml.org/lkml/2005/9/15/125 and note that
making too large of a change thrashes the users a lot and if it doesn't
solve a real problem or enable something critical, why make the changes?


--mgross

>-----Original Message-----
>From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org]
>On Behalf Of Pavel Machek
>Sent: Wednesday, November 16, 2005 12:56 AM
>To: Dave Jones; kernel list; Rafael J. Wysocki; Linux-pm mailing list
>Subject: Re: [linux-pm] [RFC] userland swsusp
>
>Hi!
>
>>  > > Even it were not for this, the whole idea seems misconcieved to
me
>>  > > anyway.
>>  >
>>  > ...but how do you provide nice, graphical progress bar for swsusp
>>  > without this? People want that, and "esc to abort", compression,
>>  > encryption. Too much to be done in kernel space, IMNSHO.
>>
>> I'll take "rootkit doesnt work" over "bells and whistles".
>
>It moves bunch of code from kernelspace to userspace. You don't have
>to add bells and whistles at the same time. That's normally called
>good thing. If Fedora has special needs, fine.
>								Pavel
>--
>Thanks, Sharp!
