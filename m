Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265883AbUGEA56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUGEA56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 20:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbUGEA55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 20:57:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20189 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265883AbUGEA54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 20:57:56 -0400
Date: Sun, 4 Jul 2004 21:28:46 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] lockup on boot with 2.4.26
Message-ID: <20040705002845.GB20847@logos.cnet>
References: <1088979352.9568.9.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088979352.9568.9.camel@nosferatu.lan>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 12:15:52AM +0200, Martin Schlemmer wrote:
> Hi
> 
> I have tried to update my gateway's kernel to 2.4.26 (Been running
> happily on 2.4.17, but a bit _old_, so finally decided this weekend
> to try and update it).   At boot though it only gets to:
> 
> --
> Uncompressing kernel... booting linux...
> --
> 
> and then locks hard (the capslock and scroll lock leds lids)
> 
> Its an old P3 450 on an Asus P2B (BX440 chipset).  .config is pretty
> much the same as for the 2.4.17 kernel.
> 
> I did have grsecurity initially applied, but I tried on an vanilla
> kernel as well (besides some netfiler POM patches, but they are all
> modules).  I also tried to disable acpi.
> 
> Any suggestions would be appreciated.  .config attached.

Hi Martin, 

I do not know the answer for your problem but I'll try to help.

Can you do a binary search and find out which v2.4 kernel stops working? 

You can start with 2.4.21, see if that works, if so, try 2.4.23, etc? 

