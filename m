Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUAJJxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 04:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUAJJxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 04:53:16 -0500
Received: from AGrenoble-101-1-5-161.w80-11.abo.wanadoo.fr ([80.11.136.161]:49898
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S265059AbUAJJxP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 04:53:15 -0500
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
	checking
From: Xavier Bestel <xavier.bestel@free.fr>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Christoph Hellwig <hch@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401100325320.1739-100000@gaia.cela.pl>
References: <Pine.LNX.4.44.0401100325320.1739-100000@gaia.cela.pl>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073728341.6189.182.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 10:52:22 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 10/01/2004 à 03:27, Maciej Zenczykowski a écrit :
> > > Like binfmt_flat? :)
> > 
> > .. or even zflat. Not that I'm proud of it, but it can effectively
> > manage to produce rather compact executables :)
> 
> Probably one of those two, is this something new?  Never heard of 
> either... :) Specs? Min bin file size?  If this (one of these) is 
> guaranteed to be in any new kernel (i.e. can't be configed out like a.out) 
> then that would be enough (assuming this flat is slim file size wise).

It can be configured out, of course, and is generally not configured for
you regular desktop. It comes from the embedded world (uCLinux) where
space on primary storage (generally flash) is one of the big costs. The
tools to generate/manipulate it are in the uCLinux distro.

	Xav

