Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbTGNTVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270729AbTGNTVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:21:17 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:49646 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S270742AbTGNTUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:20:30 -0400
Date: Mon, 14 Jul 2003 21:34:24 +0200
From: Damian Kolkowski <deimos@deimos.one.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: ajoshi@kernel.crashing.org, lkml <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: radeonfb patch for 2.4.22...
Message-ID: <20030714193424.GA1989@deimos.one.pl>
References: <Pine.LNX.4.10.10307141342420.28472-100000@gate.crashing.org> <Pine.LNX.4.55L.0307141605110.8994@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.55L.0307141605110.8994@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:dEiMoS_DK@jabber.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.22-pre5, up 49 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:11:02PM -0300, Marcelo Tosatti wrote:
> I received complains from people I trust. I'm sorry for accusing you of
> something you have not made.

There's no linux/radeonfb.h :-)

Just add it from Ani Joshi 0.1.8 patch:

.~. $ cat /src/linux/include/linux/radeonfb.h
#ifndef __LINUX_RADEONFB_H__
#define __LINUX_RADEONFB_H__

#include <asm/ioctl.h>
#include <asm/types.h>

#define ATY_RADEON_LCD_ON       0x00000001
#define ATY_RADEON_CRT_ON       0x00000002


#define FBIO_RADEON_GET_MIRROR  _IOR('@', 3, sizeof(__u32*))
#define FBIO_RADEON_SET_MIRROR  _IOW('@', 4, sizeof(__u32*))

#endif

.~. $

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
