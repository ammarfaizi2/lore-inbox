Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUFFJCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUFFJCn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUFFJCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:02:42 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:43528 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S263154AbUFFJCf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:02:35 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Subject: Re: 2.6.7-rc2-bk6 -- mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x200000
Date: Sun, 6 Jun 2004 11:02:24 +0200
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <40C28573.6070704@comcast.net> <40C2D969.4010509@gmx.de>
In-Reply-To: <40C2D969.4010509@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406061102.24483.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 of June 2004 10:44, Prakash K. Cheemplavam wrote:
> Miles Lane wrote:
> > I am getting an error using the nv open-source driver
> > for the GeForce FX 5600 board.
> >
> > vesafb: framebuffer at 0xd0000000, mapped to 0xf8808000, size 3072k
> > vesafb: mode is 1024x768x16, linelength=2048, pages=1
> > vesafb: protected mode interface info at c000:f530
> > vesafb: scrolling: redraw
> > vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
> > fb0: VESA VGA frame buffer device
> > mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x200000
>
> Well, don'T use framebuffer console and everthing will be fine.
There is no way of having both (vesafb and mtrr) at the same time?

> Prakash

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
