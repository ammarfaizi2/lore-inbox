Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130054AbRCAV2m>; Thu, 1 Mar 2001 16:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130050AbRCAV2d>; Thu, 1 Mar 2001 16:28:33 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:32413 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S130020AbRCAV2S>; Thu, 1 Mar 2001 16:28:18 -0500
Date: Thu, 1 Mar 2001 22:27:23 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, gator@cs.tu-berlin.de,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] Re: fat problem in 2.4.2
In-Reply-To: <Pine.GSO.4.21.0103011600540.11577-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.10.10103012224590.20752-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Mar 2001, Alexander Viro wrote:

> 	IOW, if it's worth doing at all it probably should be
> on expanding path in vmtruncate() - limit checks are already
> done, but old i_size is still not lost...

The fs where it's important have mmu_private, that's what I use to decide
whether to expand or truncate.

bye, Roman

