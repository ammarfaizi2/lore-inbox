Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268516AbRHFNaR>; Mon, 6 Aug 2001 09:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbRHFN36>; Mon, 6 Aug 2001 09:29:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48513 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268516AbRHFN3h>;
	Mon, 6 Aug 2001 09:29:37 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15214.39864.63824.771341@pizda.ninka.net>
Date: Mon, 6 Aug 2001 06:29:28 -0700 (PDT)
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: <jlnance@intrex.net>, Rik van Riel <riel@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33.0108061521280.4694-100000@Expansa.sns.it>
In-Reply-To: <20010803090703.B1248@bessie.localdomain>
	<Pine.LNX.4.33.0108061521280.4694-100000@Expansa.sns.it>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Luigi Genoni writes:
 > with 2.4.5 i had similar problems with 4 GB RAM on a 4-processor
 > sparc64.
 > 2.4.6 solved my problems.

It is different issue, most of slowdowns people are seeing are
due to highmem.  Sparc64 does not have highmem.

Later,
David S. Miller
davem@redhat.com
