Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136704AbREGXHN>; Mon, 7 May 2001 19:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136708AbREGXG7>; Mon, 7 May 2001 19:06:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47018 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136704AbREGXFo>;
	Mon, 7 May 2001 19:05:44 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.10822.456452.929992@pizda.ninka.net>
Date: Mon, 7 May 2001 16:05:42 -0700 (PDT)
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: "Ben LaHaise" <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero^H^H^H^Hsingle copy pipe
In-Reply-To: <001601c0d713$d60a17b0$5517fea9@local>
In-Reply-To: <mailman.989055541.17259.linux-kernel2news@redhat.com>
	<3AF6CA1B.9849CE6A@redhat.com>
	<001601c0d713$d60a17b0$5517fea9@local>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul writes:
 > If I understand the BSD direct-pipe code correctly
 > it has a swap file based backing store. I think that's insane. And
 > limiting the direct copy buffers to a few kB defeats the purpose of
 > direct copy.

Last time I studied that FreeBSD pipe code, it used a global limit for
locked memory.

Later,
David S. Miller
davem@redhat.com
