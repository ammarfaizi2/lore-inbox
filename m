Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbRC1Xk5>; Wed, 28 Mar 2001 18:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRC1Xkl>; Wed, 28 Mar 2001 18:40:41 -0500
Received: from [213.96.124.18] ([213.96.124.18]:61423 "HELO dardhal")
	by vger.kernel.org with SMTP id <S132619AbRC1XjG>;
	Wed, 28 Mar 2001 18:39:06 -0500
Date: Thu, 29 Mar 2001 01:37:41 +0000
From: =?us-ascii?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Plans for 2.5
Message-ID: <20010329013741.A6451@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <OJECKBFFEMDBJMBOKGEDKEEKCCAA.jisla@elogica.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <OJECKBFFEMDBJMBOKGEDKEEKCCAA.jisla@elogica.com.br>; from jisla@elogica.com.br on Wed, Mar 28, 2001 at 07:44:52PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 28 March 2001, at 19:44:52 -0300,
Bruno Avila wrote:

> Hello people,
> 
> 	I got some questions. When are we going to develop stuff for 2.5? What is
> planed? My opinion for linux 2.5 should be performance. Since linux already
> is stable or well done for nature, we could thing more on performance to be
> a diferencial over others. What do you people thing?
> 
My two cents. I'd like to see Linux VM subsystem "stabilize". By now, with
2.4.x I have the subjective impression that memory management is a bit
worse that on 2.2.x. For example, the kernel starts allocating much swap
space even when there is still plenty of free physical RAM. Also, it tends
not to balance well between cached/buffered data and swap space. Finally,
when an application ends and releases memroy, swap space allocated by this
application _seems_ not to be freed (that, AFAIK, is a know issue being
addressed). Don't know if this is 2.5.x stuff or can be integrated into
later 2.4.x releases.

By the way, it has been mentioned in this list that work is underway to
develop new capability based features for the kernel. Does it have
anything to do with capabilities as provided by LIDS ?. Is there a plan on
integrating this and/or other patches in the mainstream kernel ?.

Argh, too many things at once, and the worst one is that I can't help a lot
on anyone. I expect not to have given developers a bit of extra work :)

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

