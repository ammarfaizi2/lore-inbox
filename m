Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRHHGdO>; Wed, 8 Aug 2001 02:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270337AbRHHGdE>; Wed, 8 Aug 2001 02:33:04 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:48133 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S270314AbRHHGcu>; Wed, 8 Aug 2001 02:32:50 -0400
From: bvermeul@devel.blackstar.nl
Date: Wed, 8 Aug 2001 08:35:34 +0200 (CEST)
To: Patrick Mochel <mochel@transmeta.com>
cc: "Joseph N. Hall" <joseph@5sigma.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux on FIVA MPC-206E, APM and other issues
In-Reply-To: <Pine.LNX.4.10.10108071246390.14484-100000@nobelium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108080834180.25081-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't actually tried to get this card to work, but I once saw a page
> with relevant information about it:
>
> http://www.focusresearch.com/dwl-650.html
>
> (it recommends the wvlan_cs driver)

I've got it working with orinoco_cs as well. It contains a buggy CIS, so
if your PCMCIA controller only does 5V, there's a module param to tell it
to ignore that.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

