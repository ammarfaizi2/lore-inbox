Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266763AbUHIRBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266763AbUHIRBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUHIRBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:01:39 -0400
Received: from kwisatz.net1.nerim.net ([80.65.225.31]:50950 "EHLO
	www.rubis.org") by vger.kernel.org with ESMTP id S266763AbUHIRAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:00:54 -0400
Date: Mon, 9 Aug 2004 19:00:46 +0200
From: Stephane Jourdois <stephane@rubis.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       zaitcev@yahoo.com
Message-ID: <20040809170045.GA25191@diamant.rubis.org>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Filip Van Raemdonck <filipvr@xs4all.be>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
	zaitcev@yahoo.com
References: <20040808191912.GA620@elf.ucw.cz> <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian> <1092046959.21815.15.camel@pegasus> <20040809120705.GA23073@diamant.rubis.org> <1092057843.21815.21.camel@pegasus> <20040809133452.GA24530@diamant.rubis.org> <1092061267.4639.4.camel@pegasus> <20040809151229.GA8651@diamant.rubis.org> <1092070144.4564.6.camel@pegasus>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1092070144.4564.6.camel@pegasus>
X-Operating-System: Linux 2.6.8-rc3-mm2
X-Send-From: diamant.rubis.org
User-Agent: Mutt/1.5.6+20040803i
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: kwisatz@rubis.org
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: * -4.9 BAYES_00 BODY: L'algorithme  =?ISO-8859-1?Q?=20Bay=E9sien?= a  =?ISO-8859-1?Q?=20=E9?=
	=?ISO-8859-1?Q?valu=E9?= la  =?ISO-8859-1?Q?=20probabilit=E9?= de spam entre 0 et 1%
	*      [score: 0.0000]
	*  0.0 UPPERCASE_25_50 Message  =?ISO-8859-1?Q?=20compos=E9?= de 25  =?ISO-8859-1?Q?=20=E0?= 50% de majuscules
	*  0.0 AWL AWL: Auto-whitelist adjustment
X-SA-Exim-Version: 4.0 (built Sat, 24 Apr 2004 12:31:30 +0200)
X-SA-Exim-Scanned: Yes (on www.rubis.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 06:49:05PM +0200, Marcel Holtmann wrote:
> --- ub.c.orig   2004-08-09 18:40:38.000000000 +0200
> +++ ub.c        2004-08-09 18:24:15.000000000 +0200
> @@ -318,6 +318,7 @@
>  static struct usb_device_id ub_usb_ids[] = {
>         // { USB_DEVICE_VER(0x0781, 0x0002, 0x0009, 0x0009) },  /* SDDR-31 */
>         { USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
> +       { }
>  };
>  
>  MODULE_DEVICE_TABLE(usb, ub_usb_ids);

Works perfectly, indeed.
Thanks.

-- 
 ///  Stephane Jourdois         /"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement  \ /    AGAINST HTML MAIL    )))
 \\\   24 rue Cauchy             X                         ///
  \\\  75015  Paris             / \    +33 6 8643 3085    ///
