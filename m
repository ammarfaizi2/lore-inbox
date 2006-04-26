Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWDZDTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWDZDTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWDZDTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:19:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:62608 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750895AbWDZDTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:19:55 -0400
X-IronPort-AV: i="4.04,155,1144047600"; 
   d="scan'208"; a="28623176:sNHT21604982"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Tue, 25 Apr 2006 20:19:51 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392DA97EED@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZo186DA6x4iflETSC8oKNtVxEe8wAB+FCQ
From: "Gross, Mark" <mark.gross@intel.com>
To: "Corey Minyard" <minyard@acm.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
X-OriginalArrivalTime: 26 Apr 2006 03:19:53.0199 (UTC) FILETIME=[48EB6FF0:01C668E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Corey Minyard [mailto:minyard@acm.org]
>Sent: Tuesday, April 25, 2006 7:19 PM
>To: Gross, Mark
>Cc: Alan Cox; bluesmoke-devel@lists.sourceforge.net; LKML; Carbonari,
>Steven; Ong, Soo Keong; Wang, Zhenyu Z
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>Gross, Mark wrote:
>
>>>Yes, this is what I was talking about.  I believe the mode of
>>>module_param should be 444, since modifying this after the module is
>>>loaded won't do anything.  Also, it might be nice to print something
>>>different in the "force" case.
>>>
>>>
>>
>>How about printing nothing like it used too?
>>
>>See attached.
>>
>>
>This is fine with me.  I debated between printing nothing and a "You
>have chosen to override ..." print but didn't come out with any
>opinion.  I'm easy either way.
>
>The indenting in the "if (!force_function_unhide && !(stat8 & (1 <<
5)))
>{" clause is kind of strange 

I know I'm going to regret this but:  What's strange about it?

> and you have some spaces instead of tabs
>right after that (where stat8 is set).

Damn.  I pasted using the x-windows middle mouse button :(  I'll redo
the patch when I get back to my workstation tomorrow.

--mgross
