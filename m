Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUHST0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUHST0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHST0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:26:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:50598 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267298AbUHSTYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:24:05 -0400
Date: Thu, 19 Aug 2004 21:24:01 +0200
From: Olaf Hering <olh@suse.de>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Greg KH <greg@kroah.com>, Tonnerre <tonnerre@thundrix.ch>,
       ismail d?nmez <ismail.donmez@gmail.com>,
       Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Message-ID: <20040819192401.GA11475@suse.de>
References: <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com> <2a4f155d040817124335766947@mail.gmail.com> <41226512.9000405@microgate.com> <20040818062210.GB22332@suse.de> <2a4f155d040817233463d2b78d@mail.gmail.com> <20040818064229.GD22332@suse.de> <1092855516.8998.34.camel@nosferatu.lan> <20040819172846.GA15361@thundrix.ch> <1092943461.8998.50.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092943461.8998.50.camel@nosferatu.lan>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Aug 19, Martin Schlemmer wrote:

> Greg, below patch should be in order.
> 
> ---
> --- /etc/udev/rules.d/50-udev.rules.orig        2004-08-19 21:17:08.947911536 +0200
> +++ /etc/udev/rules.d/50-udev.rules     2004-08-19 21:22:48.804245520 +0200
> @@ -65,7 +65,7 @@
> 
>  # pty devices
>  KERNEL="pty[p-za-e][0-9a-f]*", NAME="pty/m%n", SYMLINK="%k"
> -KERNEL="tty[p-za-e][0-9a-f]*", NAME="tty/s%n", SYMLINK="%k"
> +KERNEL="tty[p-za-e][0-9a-f]*", NAME="pty/s%n", SYMLINK="%k"

Dont forget to update Documentation/devices.txt


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
