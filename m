Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264038AbUECViR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbUECViR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbUECViR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:38:17 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:744 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264038AbUECViI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:38:08 -0400
Date: Mon, 3 May 2004 23:24:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davidm@hpl.hp.com, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040503212450.GC31580@wohnheim.fh-wedel.de>
References: <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de> <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <20040503140251.274e1239.akpm@osdl.org> <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004 22:16:07 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> I'd rather kill open() completely - we only have a handful of in-tree users
> and there's no good reason to keep that crap, AFAICS.  I'm gathering the
> list of in-tree callers of open()/lseek()/close() and so far a lot of them
> look buggy.  More on that later...

Do you know how many of those exist purely for the purpose of passing
a struct file to one of the various read/write functions?

Jörn

-- 
The grand essentials of happiness are: something to do, something to
love, and something to hope for.
-- Allan K. Chalmers
