Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWJEPq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWJEPq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJEPq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:46:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:2864 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751518AbWJEPqz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:46:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,266,1157353200"; 
   d="scan'208"; a="140869141:sNHT3411350719"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Cast removal
Date: Thu, 5 Oct 2006 08:45:46 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A40111D87B@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Cast removal
Thread-Index: AcboVSnC6QWXXtUgSQ2J0rK9jV1jAgAP+3cw
From: "Moore, Robert" <robert.moore@intel.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Len Brown" <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "ACPI List" <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2006 15:45:47.0026 (UTC) FILETIME=[5332FF20:01C6E895]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was speaking generally, as far as casting issues go with ACPICA. We
have lots of compilers to support, as well as 16/32/64 bit issues. We
are about to remove the 16-bit support, which will clean things up a
bit.

I would appreciate a couple of examples of exactly what is being
discussed. 
Thanks.
Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> Sent: Thursday, October 05, 2006 1:00 AM
> To: Andrew Morton
> Cc: Len Brown; Brown, Len; Linux Kernel Mailing List; ACPI List
> Subject: Re: [PATCH] Cast removal
> 
> 
> >> > > I'm okay applying this patch it touches the linux-specific
> >> > > drivers/acpi/* files only, no ACPICA files.
> >> >
> >> > Why?
> >>
> >> Why am I okay with it?
> >
> >No, I meant why not clean up ACPICA too?
> 
> I was about to go through the whole kernel base for anti-casting.
Sounds
> like a big task, and probably is. I just did not want to do it all at
> once and send a mega-patch. Instead, a per-directory walk seems best
to
> me, and granted, "dispatcher events executer hardware namespace" and
all
> the other directories under drivers/acpi/ were supposed to be the next
> to be examined for casts.
>     Though if you have problems with that because compiling with ugh,
> old or broken, compilers, be my guest.
> http://www.velocityreviews.com/forums/t313918-void-casting.html
> """If your compiler requires a cast, you are using a C++ compiler."""
> Is that the case?
> 
> 
> 
> 	-`J'
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
