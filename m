Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVAXOfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVAXOfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVAXOfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:35:38 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:24214 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261269AbVAXOf1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:35:27 -0500
Date: Mon, 24 Jan 2005 15:35:29 +0100
From: Florian.Bohrer@t-online.de (Florian Bohrer)
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-Id: <20050124153529.3926d43d.Florian.Bohrer@t-online.de>
In-Reply-To: <41F4FB1D.4090302@ens-lyon.fr>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<41F4E28A.3090305@ens-lyon.fr>
	<41F4FB1D.4090302@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-ID: bdmBSZZ68eH7H7JshmRvjAzfDW1XMLViemiwp9PPiQIc1nQa4bG+wR
X-TOI-MSGID: ee9425b7-1534-4ed6-b82c-af5466ed5300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 14:41:49 +0100
Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:

> Brice Goglin a écrit :
> > Andrew Morton a écrit :
> > 
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/ 
> >>
> >>
> >>
> >> - Lots of updates and fixes all over the place.
> > 
> > 
> > Hi Andrew,
> > 
> > X does not work anymore when using DRI on my Compaq Evo N600c (Radeon 
> > Mobility M6 LY).
> > My XFree 4.3 (from Debian testing) with DRI uses drm and radeon kernel 
> > modules.
> > 
> > Instead of the usual gdm window, I get a black or noisy screen 
> > (remaining image parts of
> > last working session). The mouse pointer works. Sysrq works. But 
> > Caps-lock doesn't work.
> > The machine pings but I can't ssh.
> > 
> > I don't know exactly what's happening. I don't see anything interesting 
> > in dmesg.
> 
> Thanks to Benoit who found this at the end of dmesg:
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Couldn't find an AGP VGA controller.
> 
> while Linus' 2.6.11-rc2 says:
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
> 
> Regards,
> Brice
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

the same problem here.... with the nvidia-driver .....seems that AGP is totally brocken.

Jan 24 13:50:09 hal9000 agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
Jan 24 13:50:09 hal9000 agpgart: Couldn't find an AGP VGA controller.
-- 


-----------------------------------------------------------------------------
"Real Programmers consider "what you see is what you get" to 
be just as bad a concept in Text Editors as it is in women. 
No, the Real Programmer wants a "you asked for it, you got 
it" text editor -- complicated, cryptic, powerful, 
unforgiving, dangerous."
-----------------------------------------------------------------------------

