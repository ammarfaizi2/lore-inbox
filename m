Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVG2VnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVG2VnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVG2VnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:43:19 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:48761 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262905AbVG2Vh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:37:57 -0400
X-IronPort-AV: i="3.95,154,1120453200"; 
   d="scan'208"; a="292324298:sNHT874248680"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] modified firmware_class.c to support no hotplug
Date: Fri, 29 Jul 2005 16:37:56 -0500
Message-ID: <B37DF8F3777DDC4285FA831D366EB9E2073110@ausx3mps302.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] modified firmware_class.c to support no hotplug
Thread-Index: AcWRnSGDF+C/PkOSS36SQuNgVq33fwC6GBSQ
From: <Abhay_Salunke@Dell.com>
To: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>
X-OriginalArrivalTime: 29 Jul 2005 21:37:56.0733 (UTC) FILETIME=[C89EAAD0:01C59485]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Monday, July 25, 2005 11:47 PM
> To: Salunke, Abhay
> Cc: Greg KH
> Subject: Re: [patch 2.6.12-rc3] modified firmware_class.c to support
no
> hotplug
> 
> Abhay Salunke <Abhay_Salunke@dell.com> wrote:
> >
> > Andrew, could you please add this patch to the -mm tree.
> 
> -mm is based on Linus's post-2.6.13-rc3 tree, not on 2.6.11.x!
> 
> Please redo and retest the patches against a current development
kernel,
> then resend.

I tried building the 2.6..13-rc4 kernel by applying the 2.6..13-rc4
patch to 2.6.12 kernel source. The build goes fine but booting to the
new kernel fails giving the following errors 
Insmod error inserting /lib/sd_mod.ko' :-1 Unknown symbol in module
Error: /bin/insmod exited abnormally!
I am getting the same errors for mptscsih.ko , ext3.ko and dm-mirror.ko
modules. 
Not sure if this is a known issue...

Thanks
Abhay
