Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSE3UBV>; Thu, 30 May 2002 16:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSE3UBU>; Thu, 30 May 2002 16:01:20 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:20999 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316855AbSE3UBT>;
	Thu, 30 May 2002 16:01:19 -0400
Date: Thu, 30 May 2002 12:59:42 -0700
From: Greg KH <greg@kroah.com>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] ATM driver for the Alcatel SpeedTouch USB DSL modem
Message-ID: <20020530195942.GA29522@kroah.com>
In-Reply-To: <1022782402.1920.130.camel@ldb> <20020530184817.GB28893@kroah.com> <1022787238.1921.185.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 02 May 2002 18:56:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 09:33:58PM +0200, Luca Barbieri wrote:
> > Because of these dependencies (and the fact that the maintainer doesn't
> > want it added yet) I will not apply this patch.
> That's ok (right now). Application of it should only be considered after
> discussion here and after the maintainer responds.
> 
> > Sending this to linux-usb-devel might be a better place, instead of
> > bothering linux-kernel.
> Should I have sent the first two patches to linux-kernel, the ATM SAR to
> linux-atm-general and the SpeedTouch driver to linux-usb-devel?
> How should I have handled the fact that the SpeedTouch and ATM SAR
> patches depend on main kernel patches and the fact that the SpeedTouch
> patch includes ATM code (since it is for an ATM device attached to the
> USB bus)?

Well, if you want a ATM patch added, you need to send it to the ATM
maintainer (but I don't know if there is one right now or not.)  And if
you want a USB driver added to the USB tree, you need to send it to the
USB maintainer.  So cross-posting to all of these lists is probably a
good idea :)

greg k-h
