Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967714AbWLGCeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967714AbWLGCeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 21:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967709AbWLGCeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 21:34:03 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:58813
	"EHLO areca.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967714AbWLGCeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 21:34:01 -0500
Message-ID: <000301c719a9$70e4f8d0$2900a8c0@arecakevin>
From: "Areca Support" <support@areca.com.tw>
To: "Bron Gondwana" <brong@fastmail.fm>, <filip@euroweb97.com>
Cc: <linux-kernel@vger.kernel.org>, <erich@areca.com.tw>
References: <3193.213.203.144.13.1165423892.squirrel@mailserver.omnibit.it> <20061206230949.GA25461@brong.net>
Subject: Re: Areca driver 2.6.19 on x86_64
Date: Thu, 7 Dec 2006 10:43:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-OriginalArrivalTime: 07 Dec 2006 02:24:05.0265 (UTC) FILETIME=[C4570010:01C719A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,

This is Kevin Wang from Areca Technology, Tech-Support Team.
regarding your problem, please trying to disable ACPI in kernel loader.
if the problem happen as soon as driver loaded, it should be the IRQ
releated issue.
the motherboard bios didn't assigned a correct IRQ to controller, it makes
the driver can't initialize controller.
and in our experience, disable ACPI in kernel loader can solved this ussue
in some distro.


Best Regards,


Kevin Wang

Areca Technology Tech-support Division
Tel : 886-2-87974060 Ext. 223
Fax : 886-2-87975970
Http://www.areca.com.tw
Ftp://ftp.areca.com.tw

----- Original Message ----- 
From: "Bron Gondwana" <brong@fastmail.fm>
To: <filip@euroweb97.com>
Cc: <support@areca.com.tw>; <linux-kernel@vger.kernel.org>;
<erich@areca.com.tw>
Sent: Thursday, December 07, 2006 7:09 AM
Subject: Re: Areca driver 2.6.19 on x86_64


> On Wed, Dec 06, 2006 at 05:51:32PM +0100, filip@euroweb97.com wrote:
> > OS distro used:
> > CentOS 4.4 x86_64
> > Kernel 2.6.19 with hand-crafted config, that we are
> > able to use successfully with kernel 2.6.16.20.
>
> What patches were you applying to 2.6.16.20, since that didn't
> have an Areca driver in it I presume you're at least using that.
>
> > Have you any suggestions to resolve this issue ?
>
> 32 bit kernel?  I'm somewhat serious here, depending what applications
> you're running on the machine.
>
> Otherwise, no clue sorry - we're running 32 bit kernels everywhere
> even on the couple of new Core machines we have.
>
> Bron.

