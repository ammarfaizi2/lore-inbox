Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSJIWou>; Wed, 9 Oct 2002 18:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262474AbSJIWob>; Wed, 9 Oct 2002 18:44:31 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:61705 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262469AbSJIWoT>; Wed, 9 Oct 2002 18:44:19 -0400
Date: Thu, 10 Oct 2002 00:49:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Jeff Garzik <jgarzik@pobox.com>
cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
In-Reply-To: <3DA49496.10401@pobox.com>
Message-ID: <Pine.LNX.4.44.0210100035210.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Oct 2002, Jeff Garzik wrote:

> Which implies that the equivalent of "source drivers/net/Config*"
> (wildcarding) in Roman's system would be useful.  Or maybe "source
> drivers/net" and it knows that when given a directory it should scan for
> all Config* files in that dir.

This makes dependency checking problematic, as we constantly have to
check for new config files. How would I teach make/kbuild this?

bye, Roman

