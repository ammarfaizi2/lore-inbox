Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUAYA2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAYA2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:28:39 -0500
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:52656 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S263561AbUAYA2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:28:38 -0500
Message-ID: <40130D9F.3866691C@eyal.emu.id.au>
Date: Sun, 25 Jan 2004 11:28:15 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.25-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
		<40125540.A33B8AB2@eyal.emu.id.au> <20040125014920.54a786cc.yuasa@hh.iij4u.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoichi Yuasa wrote:
> > `/data2/usr/local/src/linux-2.4-pre/drivers/video'
> >
> > There are no it8181fb.* files there.
> 
> This file comes from a MIPS CVS tree.
> 
> I have this file.
> You can get following.
> 
> http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v2.4/it8181fb.c

Is this a MIPS only file? I run on x86 and it was selected:

   if [ "$CONFIG_PCI" = "y" -o "$CONFIG_CPU_VR41XX" = "y" ]; then
      tristate '  ITE IT8181E/F support' CONFIG_FB_IT8181
   fi 

Maybe we need a '-a' instead?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
