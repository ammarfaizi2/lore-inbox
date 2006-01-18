Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWARUiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWARUiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWARUiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:38:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:20497 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030426AbWARUiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:38:05 -0500
Date: Wed, 18 Jan 2006 21:37:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: menuconfig elements unaligned
Message-ID: <20060118203759.GB14340@mars.ravnborg.org>
References: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:20:11PM +0100, Jan Engelhardt wrote:
> Hi,
> 
> 
> in Drivers > Network > 10 or 100Mbit, this shows up:
> 
>  [*] EISA, VLB, PCI and on board controllers
>  < >   AMD PCnet32 PCI support
>  < >   AMD 8111 (new PCI lance) support
>  < >   Adaptec Starfire/DuraLAN support
>  < >   Broadcom 4400 ethernet support (EXPERIMENTAL)
>  < >   Reverse Engineered nForce Ethernet support (EXPERIMENTAL)
>  < > Digi Intl. RightSwitch SE-X support
>  < > EtherExpressPro/100 support (eepro100, original Becker driver)
>  < > Intel(R) PRO/100+ support
> 
> Deactivating EISA would suggest that Digi Intl. and everything below would
> remain visible, but they do not. If someone got the time to, please fix it.
Looks OK here.
amd64 with defconfig.

	Sam
