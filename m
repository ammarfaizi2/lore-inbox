Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVIIJPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVIIJPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVIIJPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:15:09 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:39439
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965111AbVIIJPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:15:07 -0400
Message-Id: <43216EFB020000780002489B@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 11:16:11 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>, <discuss@x86-64.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <200509091054.11932.ak@suse.de>
In-Reply-To: <200509091054.11932.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 09.09.05 10:54:11 >>>
>On Thursday 08 September 2005 18:04, Jan Beulich wrote:
>> (Note: Patch also attached because the inline version is certain to
get
>> line wrapped.)
>>
>> Allow building the x86-64 kernels with frame pointers if so needed.
>
>This doesn't work because you would need to pass
-fno-omit-frame-pointer
>somewhere.

So is done in the top-level makefile.

>Also I don't see much sense because all the assembly code
>will break the frame chains.

Sure, but that's a different issue.

Jan
