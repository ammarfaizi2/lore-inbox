Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278229AbRJWUhQ>; Tue, 23 Oct 2001 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278225AbRJWUg5>; Tue, 23 Oct 2001 16:36:57 -0400
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:2323 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S278226AbRJWUgu>;
	Tue, 23 Oct 2001 16:36:50 -0400
Date: Tue, 23 Oct 2001 22:37:06 +0200
From: Werner Almesberger <wa@almesberger.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
Message-ID: <20011023223706.A8463@almesberger.net>
In-Reply-To: <3BD5ABF3.1040404@usa.net> <9r4c24$g2k$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9r4c24$g2k$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Oct 23, 2001 at 11:14:28AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> The right thing is to get rid of the old initrd compatibility cruft,
> but that's a 2.5 change.

Yes, change_root is obsolete (and relies on assumptions that are no
longer valid in several cases), and there has been plenty of time for
distributors to switch. An early funeral in 2.5 is a good idea.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
