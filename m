Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVGUH27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVGUH27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 03:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVGUH27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 03:28:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:43692 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261663AbVGUH2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 03:28:00 -0400
Date: Thu, 21 Jul 2005 09:27:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050721072758.GC17431@wohnheim.fh-wedel.de>
References: <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <20050720112127.GC3890@wohnheim.fh-wedel.de> <20050720181101.GB11609@taniwha.stupidest.org> <20050721072003.GA17431@wohnheim.fh-wedel.de> <20050721072517.GA26791@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050721072517.GA26791@taniwha.stupidest.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 July 2005 00:25:17 -0700, Chris Wedgwood wrote:
> On Thu, Jul 21, 2005 at 09:20:03AM +0200, J?rn Engel wrote:
> 
> > In both cases, what used to be a proper offset in one fd can be
> > complete bogus for another one.
> 
> Exactly.
> 
> Knowing the position within a directory is of questionable value and
> trying to implement any reliable semantics for lseek is futile.

We surely agree on that one.  But I guess Jan has something else in
mind with this patch.  See my other reply.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
