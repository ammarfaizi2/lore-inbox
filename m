Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUJPRoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUJPRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 13:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267823AbUJPRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 13:44:25 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:39825 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266183AbUJPRoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 13:44:24 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YFol12CPnJnvSIZkpZSrzlzW6s/6WPU4bOWLdRPFz8y1BLYe5/3cX5NohMjJIGwB3oF1Uol5Rt1ewyw7gg3RXOeOmQdLEXwiLKSeZ2/lDyOGdS3uY+S889A3kOU2g46jezTdetaCyYW9cgD0x7AtM1LvLj3D/C46YJDdMopcWgg
Message-ID: <9e47339104101610447a393abc@mail.gmail.com>
Date: Sat, 16 Oct 2004 13:44:23 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Kendall Bennett <kendallb@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <416E6ADC.3007.294DF20D@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What this means is that it should be possible to build a new version of
> the VESA framebuffer console driver for the Linux kernel that will have
> these important features:
> 
> 1. Be able to switch display modes on the fly, supporting all modes
> enumerated by the Video BIOS.
> 
> 2. Be able to support refresh rate control on graphics cards that support
> the VBE 3.0 services.

How is this going to work if there are multiple graphics cards
installed? Each card will want to install it's own VBE extension
interrupt.

-- 
Jon Smirl
jonsmirl@gmail.com
