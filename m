Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbSJVKiq>; Tue, 22 Oct 2002 06:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbSJVKiq>; Tue, 22 Oct 2002 06:38:46 -0400
Received: from coruscant.franken.de ([193.174.159.226]:33444 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S262409AbSJVKio>; Tue, 22 Oct 2002 06:38:44 -0400
Date: Mon, 21 Oct 2002 23:55:34 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Netfilter Mailinglist <netfilter@lists.netfilter.org>
Subject: Re: 2.4.20-pre7: ip_conntrack: table full, dropping packet.
Message-ID: <20021021215534.GB3039@naboo.club.berlin.ccc.de>
References: <20021021201644.166db824.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021201644.166db824.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.19-pre4-ben0
X-Date: Today is Sweetmorn, the 72nd day of Bureaucracy in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 08:16:44PM +0200, Stephan von Krawczynski wrote:
> Hello all,

Hi Stephan. Don't know if you remember me, but we've met at some IN e.V.
meetings in the past ;)

> After several days running kernel 2.4.20-pre7 I came across the syslogged
> message:
> 
> kernel: ip_conntrack: table full, dropping packet.
> 
> This box runs about 10 rules for destination nat. My simple question:
> is this a bug, or a need to tune something? If it is a bug, is there a
> later kernel that has it fixed?

it's not about the number of NAT rules, but the number of connections
going on through your machine.

the FAQ (to be found at www.netfilter.org) describes how to raise the
number of connection tracking table entries.

> Regards,
> Stephan

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
