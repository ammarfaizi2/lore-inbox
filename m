Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264791AbRF1W3l>; Thu, 28 Jun 2001 18:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264794AbRF1W3W>; Thu, 28 Jun 2001 18:29:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4254 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264791AbRF1W3U>;
	Thu, 28 Jun 2001 18:29:20 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15163.44990.304436.360220@pizda.ninka.net>
Date: Thu, 28 Jun 2001 15:29:18 -0700 (PDT)
To: Ben LaHaise <bcrl@redhat.com>
Cc: Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
 achi ne
In-Reply-To: <Pine.LNX.4.33.0106281823000.32276-100000@toomuch.toronto.redhat.com>
In-Reply-To: <15163.43319.82354.562310@pizda.ninka.net>
	<Pine.LNX.4.33.0106281823000.32276-100000@toomuch.toronto.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben LaHaise writes:
 > On Thu, 28 Jun 2001, David S. Miller wrote:
 > 
 > > Please note that this is nonstandard and undocumented behavior.
 > >
 > > This is not a supported API at all, and the way 64-bit DMA will
 > > eventually be done across all platforms is likely to be different.
 > 
 > Well, what is the standard API to use?  All these 64 bit cards in my
 > machine really make that 95% cpu usage in bounce buffer copying rather
 > depressing.

There simply is no standard API for 64-bit DAC, sorry.

This isn't changing in 2.4.x, please face facts.  It simply is not
a feature of 2.4.x, and we are well beyond feature freeze now.

It is certainly changing in 2.5.x which is just around the corner.

Later,
David S. Miller
davem@redhat.com
