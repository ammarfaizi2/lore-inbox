Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136047AbREHDWe>; Mon, 7 May 2001 23:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbREHDWY>; Mon, 7 May 2001 23:22:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34988 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136047AbREHDWN>;
	Mon, 7 May 2001 23:22:13 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.26207.768685.708804@pizda.ninka.net>
Date: Mon, 7 May 2001 20:22:07 -0700 (PDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105072234580.7685-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0105071929190.8237-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0105072234580.7685-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > I was wrong. The patch is indeed buggy because of the __GFP_IO thing.

What about the __GFP_IO thing?

Specifically, what protects the __GFP_IO thing from happening without
my patch?

Later,
David S. Miller
davem@redhat.com
