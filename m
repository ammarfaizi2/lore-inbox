Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbTALUzD>; Sun, 12 Jan 2003 15:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTALUzC>; Sun, 12 Jan 2003 15:55:02 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:3601 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267409AbTALUzC>;
	Sun, 12 Jan 2003 15:55:02 -0500
Date: Sun, 12 Jan 2003 22:03:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: make xconfig broken in bk current
Message-ID: <20030112210349.GA14612@mars.ravnborg.org>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
References: <200301121512.59840.tomlins@cam.org> <20030112203150.GA53199@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030112203150.GA53199@compsoc.man.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 08:31:50PM +0000, John Levon wrote:
> Can I just repeat my request to move this Qt stuff entirely out of the
> kernel package, where it belongs ?

I would like to see it stay within the kernel for the following reasons:
1) It works as it is for those who have QT
2) It's more appealing to some people with a grapical frontend
3) If it fails, people can revert back to menuconfig
4) It does not take up much space. ~2 files

The problem seems that some people does not like the QT choice.
But only one attemp has been made (that I know of) implementing
an alternative graphical frontend. (Romain Lievin - GTK)

I you do not like the QT version - don't use it.
If too many people post error - get it fixed.
Simple...

	Sam
