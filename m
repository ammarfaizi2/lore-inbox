Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUAMOoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 09:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbUAMOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 09:44:00 -0500
Received: from postbode01.zonnet.nl ([62.58.50.88]:35304 "EHLO
	postbode01.zonnet.nl") by vger.kernel.org with ESMTP
	id S264321AbUAMOn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 09:43:59 -0500
From: S Ait-Kassi <sait-kassi@zonnet.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [update] Vesafb problem since 2.5.51
Date: Tue, 13 Jan 2004 15:47:11 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401131547.11147.sait-kassi@zonnet.nl>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.2; VDF: 6.23.0.29; host: postbode01.zonnet.nl)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 21:57, you wrote:
> That is a normal config. I have the same thing. Try my latest patch. I did
> a up data again. This time the patch is against 2.6.0-rc3.
>
> P.S
>    Have tried the Radeon fbdev driver ?

I have before but I only got a blank screen. I just tried it with the latest 
patch and it does work and doesn't exhibit the problem but has a couple of
drawbacks. The ACPI information and the start comes up distorted probably 
because the framebuffer is getting initialized. I either get characters a 
mile apart. (i.e. i         n                      f                       o) 
and I just got some colored confetti instead of (ACPI) information. 

That's not really my biggest problem because that would be the fact that my 
tv-out isn't working. Looks like it's out of sync. The documentation on how 
to control the framebuffer seems to be lacking somewhat. I don't no if the 
ati-setup which was reintroduced could help me there? (I couldn't find it by 
the way) The append="video=radeonfb:1024x768-24@85" doesn't seem to work
for me in the lilo config (I also tried radeon instead of radeonfb). I only 
get a reolution 640x480 screen @60hz. The vesa framebuffer seems to be able
to control the tv-out independent of the resolution of the monitor. I don't 
know if it's an issue with the radeonfb or that it just not featured?

Thanks,

S Ait-Kassi

