Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSLJCzI>; Mon, 9 Dec 2002 21:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266527AbSLJCzI>; Mon, 9 Dec 2002 21:55:08 -0500
Received: from rth.ninka.net ([216.101.162.244]:59368 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S266520AbSLJCzH>;
	Mon, 9 Dec 2002 21:55:07 -0500
Subject: Re: [PATCH 2.4] IP: disable ECN support by default - Config option
From: "David S. Miller" <davem@redhat.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200212100316.59910.m.c.p@wolk-project.de>
References: <200212100316.59910.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 19:28:21 -0800
Message-Id: <1039490901.18047.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_INET_ECN does exactly what you want.

If you turn it on, ECN is on by default.
If you turn it off, ECN is off by default.

The ECN support itself, is always compiled into the
kernel.  CONFIG_INET_ECN only determines the initial
setting of the ecn sysctl.

Your patch adds zero functionality and only serves to make
the cofiguration more complicated.

