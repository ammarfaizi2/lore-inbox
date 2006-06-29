Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWF2AOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWF2AOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWF2AOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:14:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43669 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751834AbWF2AOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:14:24 -0400
Date: Thu, 29 Jun 2006 02:14:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       klibc@zytor.com
Subject: Re: [klibc 07/31] i386 support for klibc
In-Reply-To: <44A2A147.9020501@zytor.com>
Message-ID: <Pine.LNX.4.64.0606290207580.17704@scrub.home>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
 <klibc.200606272217.07@tazenda.hos.anvin.org> <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr>
 <44A2A147.9020501@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Jun 2006, H. Peter Anvin wrote:

> The i386 ones are a bit special... usually the reason I have added libgcc
> functions is that on some architectures, gcc has various problems linking with
> libgcc in some configurations.

If gcc has problems to link its own libgcc you really have a serious 
problem...
The standard libgcc may not be as small as you like, but it still should 
be the first choice. If there is a problem with it, the gcc people do 
accept patches.

bye, Roman
