Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbSK3N5s>; Sat, 30 Nov 2002 08:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbSK3N5r>; Sat, 30 Nov 2002 08:57:47 -0500
Received: from twister.ispgateway.de ([62.67.200.3]:19722 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S267247AbSK3N5p>; Sat, 30 Nov 2002 08:57:45 -0500
Date: Sat, 30 Nov 2002 15:05:18 +0100
From: Steffen Moser <lists@steffen-moser.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Javier Marcet <jmarcet@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021130140518.GB1735@steffen-moser.de>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Javier Marcet <jmarcet@pobox.com>, linux-kernel@vger.kernel.org
References: <20021129115405.GD15682@jerry.marcet.dyndns.org> <Pine.LNX.4.44L.0211291429260.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211291429260.15981-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* On Fri, Nov 29, 2002 at 02:31 PM (-0200), Rik van Riel wrote:

> On Fri, 29 Nov 2002, Javier Marcet wrote:
> 
> > In recent 2.4.20 pre and rc kernels ( I tend to use the ac branch ), I
> > had notice my system, when using X mainly, got terribly slow after some
> > use.
> 
> First, lets get one thing straight:  the problem is the slowness,
> not necessarily the swap usage.  

I've experienced a similar problem with "linux-2.4.20-rc2-ac3", 
"linux-2.4.20-rc4-ac1" and "linux-2.4.20-ac1". At first I also
thought it's a swap problem, but this seems to be a wrong con-
clusion, too. 

The problem occurs, for example, when Mozilla and RealPlayer are
running and I start to compile something or copy large files. The 
RealPlayer interrupts, the mouse sometimes doesn't move smoothly 
any more, and so on. 

Using "linux-2.4.20" I don't see this behaviour.

I've collected some information when running "linux-2.4.20-ac1" 
and "linux-2.4.20". I've uploaded it to:

  http://www.uni-ulm.de/~s_smoser/lkml/

The "vmstat"- and "ps"-files were created during the "cp" of about 
2,5 GB of data from one hard disk to the other one. 

Bye,
Steffen
