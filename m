Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292353AbSBUMWc>; Thu, 21 Feb 2002 07:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292354AbSBUMWX>; Thu, 21 Feb 2002 07:22:23 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:58636 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292353AbSBUMWJ>; Thu, 21 Feb 2002 07:22:09 -0500
Date: Thu, 21 Feb 2002 13:21:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <3C74DCA1.B1DA0C30@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0202211312510.2318-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Feb 2002, Jeff Garzik wrote:

> FWIW a much better transition path is very close to what your tool does,
> and is a suggestion made by mec (kbuild maintainer) near the end of the
> recent flamewar:  convert config.in files one at a time, like we did the
> old makefiles.

That's possible, as soon as the menu information is added, both formats
contain the same information, so a program with two parsers can handle
both simultaneously.

> That would imply a rewrite of make [old]config, and an updating of make
> menu|xconfig, to handle the new format...

I think we should just dump the old tools and implement a single config
library, which exports an interface to access the config information.

bye, Roman

