Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbSJBQlL>; Wed, 2 Oct 2002 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263178AbSJBQlL>; Wed, 2 Oct 2002 12:41:11 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32775 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263177AbSJBQlK>;
	Wed, 2 Oct 2002 12:41:10 -0400
Date: Wed, 2 Oct 2002 18:46:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA 'make menuconfig exits' fix
Message-ID: <20021002184616.A1329@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <E17wk9W-0005c1-00@scrub.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17wk9W-0005c1-00@scrub.xs4all.nl>; from zippel@linux-m68k.org on Wed, Oct 02, 2002 at 04:07:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 04:07:02PM +0200, Roman Zippel wrote:
> Below is a better patch + another sparc sound config fix.

Speaking about SPARC and audio:
Is the following line in drivers/sbus/Mafilefile bogus?
obj-$(CONFIG_SPARCAUDIO) += audio/

There is no audio directory as of today.

	Sam

