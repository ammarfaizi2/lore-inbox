Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbSIZAal>; Wed, 25 Sep 2002 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261461AbSIZAal>; Wed, 25 Sep 2002 20:30:41 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:63167 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261458AbSIZAak>; Wed, 25 Sep 2002 20:30:40 -0400
Date: Wed, 25 Sep 2002 21:35:41 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Lightweight Patch Manager <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux
In-Reply-To: <15762.20827.271317.595537@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.44L.0209252133490.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Peter Chubb wrote:

> +#define slist_del(_head, _entry)		\
>
> This only works if head->next == entry otherwise you lose half your
> list.  Also, none of this is SMP-safe.

Oh boy, this is the material bad jokes are made from ...

Q: How many lightweight patch managers does it take to do a
   singly linked list list_del ?
A: 4, two to hold down the list head, one to chop off the tail
   and another one to sweep the lost entries under the carpet.

Sorry, but I couldn't resist this one ;)

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org


