Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUECWBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUECWBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUECWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:01:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37031 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264076AbUECWBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:01:13 -0400
Date: Mon, 3 May 2004 23:01:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davidm@hpl.hp.com, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040503220110.GJ17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <20040503140251.274e1239.akpm@osdl.org> <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk> <20040503212450.GC31580@wohnheim.fh-wedel.de> <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 10:54:34PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 	b) systemcfg_init() in asm-ppc64/systemcfg.h (WTF is that about?)

... outside of __KERNEL__, so looks like a userland code that got there
for fsck knows what reason.  Anyway, open() and close() in it are libc
ones.
