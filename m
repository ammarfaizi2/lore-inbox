Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272868AbTG3M0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272867AbTG3M0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:26:52 -0400
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:55018 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id S272868AbTG3M0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:26:50 -0400
Subject: Re: 2.6.0-test 2 & matroxfb or orinoco wifi card
From: Adam Voigt <adam@cryptocomm.com>
Reply-To: adam@cryptocomm.com
To: Jan Huijsmans <huysmans@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20030729223514.huysmans@xs4all.nl>
References: <XFMail.20030729223514.huysmans@xs4all.nl>
Content-Type: text/plain
Organization: Cryptocomm
Message-Id: <1059568034.2439.2.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 08:27:15 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2003 12:26:49.0648 (UTC) FILETIME=[D98C6B00:01C35695]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Might be not the same, but I got this same
error when I forgot to check "Virtual Terminal"
in the config.


On Tue, 2003-07-29 at 16:35, Jan Huijsmans wrote:
> Hello,
> 
> After digging a bit in the archives I couldn't find the solution to my problem,
> so I'm asking you guys.
> 
> I found the "matroxfb and 2.6.0-test2" thread, so it's possible to compile the
> kernel with the matrox framebuffer, but I can't find what I'm missing. Did I
> forget to set a config option (all copied from the 2.4.21 config except the
> nForce2 agp chipset)?
> 
> This is the error I'm getting while linking. 
> 
> drivers/built-in.o(.text+0x89c80): In function `matroxfb_set_par':
> : undefined reference to `default_grn'
> drivers/built-in.o(.text+0x89c85): In function `matroxfb_set_par':
> : undefined reference to `default_blu'
> drivers/built-in.o(.text+0x89c93): In function `matroxfb_set_par':
> : undefined reference to `color_table'
> drivers/built-in.o(.text+0x89c9b): In function `matroxfb_set_par':
> : undefined reference to `default_red'
> 
> I would suspect I'm missing libraries, but I don't know which set. I'm runnig
> with a dabian sarge distro, the system has an Athlon XP CPU, with asus A7N8X-X
> mainboard, matrox G550 graphics card.
> 
> Could someone point me in the right direction to get this working?
> 
> ---
> 
> Jan Huijsmans              kernel@koffie.nu
> 
> ... cannot activate /dev/brain, no response from main coffee server
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Adam Voigt (adam@cryptocomm.com)
Linux/Unix Network Administrator
The Cryptocomm Group

