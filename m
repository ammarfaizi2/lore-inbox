Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSDDM3G>; Thu, 4 Apr 2002 07:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSDDM24>; Thu, 4 Apr 2002 07:28:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63755 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293680AbSDDM2k>; Thu, 4 Apr 2002 07:28:40 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: cw@f00f.org (Chris Wedgwood)
Date: Thu, 4 Apr 2002 13:06:28 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel),
        tigran@aivazian.fsnet.co.uk (Tigran Aivazian),
        root@chaos.analogic.com (Richard B. Johnson),
        kraxel@bytesex.org (Gerd Knorr), linux-kernel@vger.kernel.org,
        hugh@veritas.com (Hugh Dickins)
In-Reply-To: <20020404055902.GA6889@tapu.f00f.org> from "Chris Wedgwood" at Apr 03, 2002 09:59:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16t60a-0005nG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this is a little unfair.  For the vast numbers of nvidia users
> I don't think there are that many problems reported and I'm not
> convinced the CURRENT nvidia drivers are necessarily doing anything
> bad[1].

Its very hard to tell. Most people I ask cannot reproduce their crashes with
the Nvidia driver unloaded. Equally many of them only got one crash in weeks
anyway.

Some of the stuff is more clear - the business about 4Mb pages on Athlon for
example. That may be a hardware, a driver or even a subtle interaction with
something elsewhere in the kernel - eg the memcpy prefetching bug I fixed
in 2.4.19-pre4-ac4

It doesn't alter the fact that its undebuggable by the community, and that is
the real problem. Fortunately the open source nvidia driver work seems to be
at the point it can just about play Quake2/3
