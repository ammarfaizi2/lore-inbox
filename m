Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSKTUet>; Wed, 20 Nov 2002 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSKTUet>; Wed, 20 Nov 2002 15:34:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38410 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261868AbSKTUer>;
	Wed, 20 Nov 2002 15:34:47 -0500
Message-ID: <3DDBF383.3020907@pobox.com>
Date: Wed, 20 Nov 2002 15:41:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andre Hedrick <andre@linux-ide.org>, Cort Dougan <cort@fsmlabs.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Mark Mielke <mark@mark.mielke.cc>, Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
References: <Pine.LNX.4.10.10211201152000.3892-100000@master.linux-ide.org> <1037825373.3241.69.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <Pine.LNX.4.10.10211201152000.3892-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Wed, 2002-11-20 at 19:55, Andre Hedrick wrote:
>
> >So " -fno-inline " should be enough to squelch the extremists?
>
>
> Its not relevant to the discussion even.


That's $topic AFAICS.  Some armchair lawyers are alleging that 
#include'ing GPL'd kernel code into non-GPL'd binary kernel module makes 
that module a derivative work and thus must be GPL'd itself.

Have we decided that #include'ing GPL'd code does, or does not, taint 
otherwise "license-clean" code that includes the GPL'd code?

The only thing I've seen from Linus is him mentioning that this is a 
"grey area".  Given this message:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103487469728730&w=2

we fall to copyright law, and wonder aloud if an obviously-non-derived 
work #includes GPL'd code, does it become derived?

	Jeff



