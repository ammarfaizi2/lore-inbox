Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263414AbRFHTGB>; Fri, 8 Jun 2001 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263660AbRFHTFv>; Fri, 8 Jun 2001 15:05:51 -0400
Received: from [216.101.162.242] ([216.101.162.242]:29056 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S263414AbRFHTFk>;
	Fri, 8 Jun 2001 15:05:40 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15137.8668.590390.10485@pizda.ninka.net>
Date: Fri, 8 Jun 2001 12:05:00 -0700 (PDT)
To: Felix von Leitner <leitner@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel headers violate RFC2553
In-Reply-To: <20010608195719.A4862@fefe.de>
In-Reply-To: <20010608195719.A4862@fefe.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Felix von Leitner writes:
 > glibc works around this, but the diet libc uses the kernel headers and
 > thus exports the wrong API to user land.

Don't user kernel headers for userspace.

Kernel headers and user headers are distinctly different namespaces,
and you have pointed out only one of many places where we use
different names/structures/etc. for some kernel networking headers
vs. what userspace wants.

Later,
David S. Miller
davem@redhat.com
