Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSLINsI>; Mon, 9 Dec 2002 08:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSLINsI>; Mon, 9 Dec 2002 08:48:08 -0500
Received: from cibs9.sns.it ([192.167.206.29]:17157 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S265446AbSLINsH>;
	Mon, 9 Dec 2002 08:48:07 -0500
Date: Mon, 9 Dec 2002 14:55:14 +0100 (CET)
From: venom@sns.it
To: John Bradford <john@grabjohn.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, <roy@karlsbakk.net>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       <alan@redhat.com>
Subject: Re: BUG in 2.5.50
In-Reply-To: <200212091346.gB9DkcgN000690@darkstar.example.net>
Message-ID: <Pine.LNX.4.43.0212091450020.1376-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2002, John Bradford wrote:

> > please try without it.
>
> Is IDE TCQ liable to corrupt data on read-only volumes or just
> read-write?  The problem with nobody using it, is that it never gets
> tested - if there are no known issues with read-only use it would be
> nice to know.

Well, to say the truth, when I tested it with 2.4.49, my IBM disk was running
mutch slower than without TCQ, so I rebuilt a kernel without it just after one
hour of tests.
I think it will be difficoult that people will use it longer that 5 minutes if
they don't see some performance gain (except people using it because they
have some serious interess to develop IDE TCQ code).
On the other side, also if there are stability problems, a lot of people will
test it if they think they can gain a better performance.

bests

Luigi

