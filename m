Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTENUnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTENUni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:43:38 -0400
Received: from ns.suse.de ([213.95.15.193]:49926 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262824AbTENUnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:43:37 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
	<buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<Pine.LNX.4.44.0305131710280.5042-100000@serv>
	<20030513211749.GA340@gnu.org>
	<Pine.LNX.4.44.0305142014500.5042-100000@serv>
From: Andreas Schwab <schwab@suse.de>
X-Yow: If our behavior is strict, we do not need fun!
Date: Wed, 14 May 2003 22:56:24 +0200
In-Reply-To: <Pine.LNX.4.44.0305142014500.5042-100000@serv> (Roman Zippel's
 message of "Wed, 14 May 2003 21:51:56 +0200 (CEST)")
Message-ID: <jellx9b62v.fsf@sykes.suse.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

|> Hi,
|> 
|> On Tue, 13 May 2003, Miles Bader wrote:
|> 
|> > BTW, the name `enable' seems to be a misnomer -- `enable' implies that it
|> > forces the depends to be y, but not that it also forces the _value_.
|> > 
|> > Why not have two:
|> > 
|> >   enable FOO	- forces the `depends' value of FOO to y
|> > 		  but it will still prompt
|> >   force FOO	- forces both the `depends' and value of FOO to y
|> > 		  prompting for FOO is turned off
|> 
|> I don't really like "force", it's IMO a bit too strong and too unspecific 
|> (although enable is here only a bit better). The first I'd rather call 
|> "visible", but I don't see a need for this and I wouldn't immediately know 
|> how to support this, a config entry can have multiple prompts and every 
|> prompt has its own dependencies, so which one should I enable? It would 
|> probably be easier to enable/force the dependencies so the prompt becomes 
|> visible.
|> 
|> But I'm open to suggestions for a better name, "select" might be a good 
|> alternative. Other ideas? Opinions?

How about "override"?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
