Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270480AbRHSOM3>; Sun, 19 Aug 2001 10:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270473AbRHSOMT>; Sun, 19 Aug 2001 10:12:19 -0400
Received: from www.transvirtual.com ([206.14.214.140]:57614 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S270472AbRHSOMC>; Sun, 19 Aug 2001 10:12:02 -0400
Date: Sun, 19 Aug 2001 07:12:09 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: mj@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Patch, please TEST: linux-2.4.9 console font
 modularization
In-Reply-To: <20010819015656.A369@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10108190709370.1190-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


See Geerts email about the proper solution. The only reason we have font
images in the kernel is because fbdev devices usually don't have hardware
fonts. Otherwise we wouldn't have them here. Personally I like to seem
them __initdata so they go away after boot time.

