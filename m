Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267088AbSKSFG1>; Tue, 19 Nov 2002 00:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267087AbSKSFG1>; Tue, 19 Nov 2002 00:06:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43525 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267085AbSKSFG0>; Tue, 19 Nov 2002 00:06:26 -0500
Date: Mon, 18 Nov 2002 21:13:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.48
In-Reply-To: <20021118193359.6ab0ae99.us15@os.inf.tu-dresden.de>
Message-ID: <Pine.LNX.4.44.0211182111190.23990-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Nov 2002, Udo A. Steinberg wrote:
> 
> 2.5.48 broke completely monolithic kernels.

Ok, this should be fixed in current -bk (snapshots will be built at 4AM 
PST as usual, so they should show up reasonably soon).

I also merged/updated the old kallsyms fixups from Rusty, so together with
the updated module loader we should be back to "working order" both
without and with modules and not missing any features.

Please test,

		Linus

