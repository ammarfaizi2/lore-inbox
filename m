Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbULNVU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbULNVU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbULNVU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:20:58 -0500
Received: from denise.shiny.it ([194.20.232.1]:55948 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S261665AbULNVUo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:20:44 -0500
Date: Tue, 14 Dec 2004 22:20:05 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: =?ISO-8859-1?Q?Antonio_P=E9rez?= <aperlu@telefonica.net>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
In-Reply-To: <41BE1399.8010300@telefonica.net>
Message-ID: <Pine.LNX.4.58.0412142218590.10830@denise.shiny.it>
References: <20041213212603.4e698de6.pochini@shiny.it> <41BE1399.8010300@telefonica.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Dec 2004, [ISO-8859-1] Antonio Pérez wrote:

> Giuliano Pochini wrote:
>
> >I can't make NAT work on 2.6.9. Outgoing packets are translated and sent,
> >but incoming packets get rejected. pc4 is the other box (inside the NAT) and
> >host164-26... is the dynamic address of my machine:
> >[...]
> >
> add this:
> echo 0 > /proc/sys/net/ipv4/tcp_bic
> echo 0 > /proc/sys/net/ipv4/tcp_ecn
> echo 0 > /proc/sys/net/ipv4/tcp_vegas_conf_avoid
>
> please , tell me if this work.

Nope, it doesn't.


--
Giuliano.
