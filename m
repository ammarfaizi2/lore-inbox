Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265452AbRF1Anm>; Wed, 27 Jun 2001 20:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265461AbRF1Anc>; Wed, 27 Jun 2001 20:43:32 -0400
Received: from [216.101.162.242] ([216.101.162.242]:13204 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S265452AbRF1AnV>;
	Wed, 27 Jun 2001 20:43:21 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.32104.479954.26216@pizda.ninka.net>
Date: Wed, 27 Jun 2001 17:42:16 -0700 (PDT)
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200106280007.f5S07qQ04446@mule.m17n.org>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NIIBE Yutaka writes:
 > Actually, I really wonder why current code causes no problem in other
 > architectures.

Probably because DMA mapping interfaces take care of all flushing
details after I/O is complete.

Later,
David S. Miller
davem@redhat.com
