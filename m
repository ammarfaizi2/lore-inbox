Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbTENTjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbTENTjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:39:37 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:18194 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261210AbTENTjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:39:35 -0400
Date: Wed, 14 May 2003 21:51:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Miles Bader <miles@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <20030513211749.GA340@gnu.org>
Message-ID: <Pine.LNX.4.44.0305142014500.5042-100000@serv>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
 <buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp> <Pine.LNX.4.44.0305131710280.5042-100000@serv>
 <20030513211749.GA340@gnu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 May 2003, Miles Bader wrote:

> BTW, the name `enable' seems to be a misnomer -- `enable' implies that it
> forces the depends to be y, but not that it also forces the _value_.
> 
> Why not have two:
> 
>   enable FOO	- forces the `depends' value of FOO to y
> 		  but it will still prompt
>   force FOO	- forces both the `depends' and value of FOO to y
> 		  prompting for FOO is turned off

I don't really like "force", it's IMO a bit too strong and too unspecific 
(although enable is here only a bit better). The first I'd rather call 
"visible", but I don't see a need for this and I wouldn't immediately know 
how to support this, a config entry can have multiple prompts and every 
prompt has its own dependencies, so which one should I enable? It would 
probably be easier to enable/force the dependencies so the prompt becomes 
visible.

But I'm open to suggestions for a better name, "select" might be a good 
alternative. Other ideas? Opinions?

bye, Roman

