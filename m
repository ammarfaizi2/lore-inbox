Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbRHFMKf>; Mon, 6 Aug 2001 08:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268033AbRHFMKZ>; Mon, 6 Aug 2001 08:10:25 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:24840 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S268042AbRHFMKJ>; Mon, 6 Aug 2001 08:10:09 -0400
From: bvermeul@devel.blackstar.nl
Date: Mon, 6 Aug 2001 14:13:06 +0200 (CEST)
To: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS file corruption
In-Reply-To: <3B6E84A1.1A13969@crm.mot.com>
Message-ID: <Pine.LNX.4.33.0108061411420.8002-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Emmanuel Varagnat wrote:

>
> Today, I crashed the kernel and after reboot the source file
> I was working on, was completly unreadable. The size indicated
> by 'ls' seems to be good but with bad data.
>
> Is this behavior normal (because the FS seems correct) ?
> The worst I hoped is loosing the last save, but not everything.

Yes, this is normal. You're being hit by metadata only journalling.
Configure your editor to make backup files, this will make sure you can
recover the last version.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

