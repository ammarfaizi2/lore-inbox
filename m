Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUJFP2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUJFP2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUJFP2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:28:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:53143 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269146AbUJFP2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:28:49 -0400
Date: Wed, 6 Oct 2004 17:28:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-ID: <20041006152848.GA10153@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua> <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be> <20041006121534.GA8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be> <20041006133310.GD8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061548390.20160@waterleaf.sonytel.be> <20041006141231.GA6394@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061619460.20160@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410061619460.20160@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: geert@linux-m68k.org, willy@w.ods.org, vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 16:23:27 +0200, Geert Uytterhoeven wrote:
> 
> Ehrm, what do you mean with `default' console?
> 
> If you mean `console as defined under nr.2',
correct
> yes, you want the console that
> does do input.

*I* don't always do.  Remember how this thread got started? ;)

> > Taking the last one registered is basically random.  If people care
> > enough, they should explicitly state things on the command line.
> 
> No, it's not. It's explicitly mentioned in the docs: if you use multiple
> `console=', all of them get output, but input comes from the last one.

Ah, true.  I was barking up the "the was no 'console=' option, take
the default" tree.  Just started looking at the console code a few
days ago.

Still, it currently is the official interface and allows the user to
do the right thing.  It doesn't exactly make it hard to do the wrong
thing, though.  On Rusty's scale it should rate as 7 or 8.
http://www.ozlabs.com/~rusty/ols-2003-keynote/img48.html

Can you think of a simple way to improve things?

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
