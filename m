Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTFGQ4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTFGQ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:56:04 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:48134 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263273AbTFGQ4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:56:02 -0400
Date: Sat, 7 Jun 2003 19:09:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
Message-ID: <20030607170926.GB20413@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20030607152434.GQ15311@fs.tum.de> <Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl> <20030607165951.GA13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607165951.GA13377@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 06:59:51PM +0200, Adrian Bunk wrote:
> > 
> > I've seen Sam's mail but this is generic solution to quiet compiler
> > and will work for any remove_proc_entry() user.
> 
> Yup, for this specific error Sam's solution is the best one, but your 
> patch e.g. solves the ieee1394_core.c compile error I reported, too.

Actually both should be applied.
The ifdef/endif pair is redundant when Bartlomiej's patch is applied.

	Sam
