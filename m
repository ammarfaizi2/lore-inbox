Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSGVIf1>; Mon, 22 Jul 2002 04:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSGVIf1>; Mon, 22 Jul 2002 04:35:27 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:35084 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316588AbSGVIf0>; Mon, 22 Jul 2002 04:35:26 -0400
Date: Mon, 22 Jul 2002 10:37:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Keith Owens <kaos@ocs.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.25 net/core/Makefile
In-Reply-To: <20020722090704.A2052@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207221032510.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Jul 2002, Russell King wrote:

> Wouldn't it be better to fix the existing config tools to output "=n"
> instead of "# CONFIG_foo is not set" ?  IIRC they do the translation
> back and forth internally anyway, so it should be just a matter of
> removing some code from the tools.

This would mean, tristate symbols had four states instead of three. The
current shell based config systems simply don't see all symbols.
Depending on the configuration a symbol could be unset or 'n'.

bye, Roman

