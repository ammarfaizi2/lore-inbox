Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVGHNeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVGHNeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVGHNeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:34:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26547 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262654AbVGHNeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:34:22 -0400
Date: Fri, 8 Jul 2005 15:34:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: Ram <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: share/private/slave a subtree
In-Reply-To: <courier.42CE788F.00003AE7@courier.cs.helsinki.fi>
Message-ID: <Pine.LNX.4.61.0507081527040.3743@scrub.home>
References: <1120816072.30164.10.camel@localhost>           
 <1120816229.30164.13.camel@localhost>            <1120817463.30164.43.camel@localhost>
            <84144f0205070804171d7c9726@mail.gmail.com>           
 <Pine.LNX.4.61.0507081412280.3743@scrub.home>           
 <courier.42CE70EE.000029AA@courier.cs.helsinki.fi>           
 <Pine.LNX.4.61.0507081441440.3728@scrub.home> <courier.42CE788F.00003AE7@courier.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2005, Pekka J Enberg wrote:

> > You can't do that with defines?
> 
> Sure you can but have you ever tried to figure out where a group of #define
> enumerations end?

Comments? Newlines?

> Enums are a natural language construct for grouping related
> constants so why not use it? 

So are defines.

> Bottom line, there are few advantages to using enums rather than #defines
> which is why they are IMHO preferred for new code. 

Are the advantages big enough to actively discourage defines? It's nice 
that you do reviews, but please leave some room for personal preferences. 
If the code is correct and perfectly readable, it doesn't matter whether 
to use defines or enums. Unless you also intent to also debug and work 
with that code, why don't leave the decision to the author?

bye, Roman
