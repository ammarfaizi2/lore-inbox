Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132689AbQL1XmS>; Thu, 28 Dec 2000 18:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132694AbQL1XmI>; Thu, 28 Dec 2000 18:42:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63360 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132689AbQL1Xl4>;
	Thu, 28 Dec 2000 18:41:56 -0500
Date: Thu, 28 Dec 2000 14:54:52 -0800
Message-Id: <200012282254.OAA01772@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: ak@suse.de, torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001228235836.A25388@gruyere.muc.suse.de> (message from Andi
	Kleen on Thu, 28 Dec 2000 23:58:36 +0100)
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <20001228231722.A24875@gruyere.muc.suse.de> <200012282233.OAA01433@pizda.ninka.net> <20001228235836.A25388@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 28 Dec 2000 23:58:36 +0100
   From: Andi Kleen <ak@suse.de>

   Why exactly a power of two ? To get rid of ->index ? 

To make things like "page - mem_map" et al. use shifts instead of
expensive multiplies...

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
