Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319512AbSIGUGb>; Sat, 7 Sep 2002 16:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319513AbSIGUGa>; Sat, 7 Sep 2002 16:06:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53235 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319512AbSIGUGa>; Sat, 7 Sep 2002 16:06:30 -0400
Date: Sat, 7 Sep 2002 22:11:04 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Harald Welte <laforge@gnumonks.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2
In-Reply-To: <Pine.LNX.4.44.0208121943150.3382-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0209072132240.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Marcelo Tosatti wrote:

>...
> Harald Welte <laforge@gnumonks.org>:
>...
>   o [NETFILTER]: Backport newnat infrastructure to 2.4.x
>...

Hi Harald,

this patch adds a #include <linux/netfilter_ipv4/ip_conntrack_helper.h> to
ip_conntrack.h and since ip_conntrack_helper.h already has a
#include <linux/netfilter_ipv4/ip_conntrack.h> this results in a circular
dependency. Could you please fix this?

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

