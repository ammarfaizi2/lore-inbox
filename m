Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286961AbRL1SOX>; Fri, 28 Dec 2001 13:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286948AbRL1SOM>; Fri, 28 Dec 2001 13:14:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50186 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286967AbRL1SOA>; Fri, 28 Dec 2001 13:14:00 -0500
Subject: Re: State of the new config & build system
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 28 Dec 2001 18:24:02 +0000 (GMT)
Cc: garzik@havoc.gtf.org (Legacy Fishtank), davej@suse.de (Dave Jones),
        esr@snark.thyrsus.com (Eric S. Raymond),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 28, 2001 10:02:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K1fn-0001Ky-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So if somebody really wants to help this, make scripts that generate
> config files AND Configure.help files from a distributed set. And once you
> do that, you could even imagine creating the old-style config files

Something like:

	find $TOPDIR -name "*.cf" -exec cat {} \; > Configure.help 

or changing the tools to look for 

	Documentation/Configure/CONFIG_SMALL_BANANA

??

Alan



