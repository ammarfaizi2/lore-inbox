Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTBLPaY>; Wed, 12 Feb 2003 10:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTBLPaY>; Wed, 12 Feb 2003 10:30:24 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:24847 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267242AbTBLPaX>; Wed, 12 Feb 2003 10:30:23 -0500
Date: Wed, 12 Feb 2003 15:40:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (0/34) summary
Message-ID: <20030212154012.C10171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Wed, Feb 12, 2003 at 10:17:37PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 10:17:37PM +0900, Osamu Tomita wrote:
> This is patchset to support NEC PC-9800 subarchitecture against 2.5.60.
> 
> You can get this patchset from URL bellow.
> http://downloads.sourceforge.jp/linux98/2350/linux98-2.5.60.patch.tar.bz2
> Comments and test reports are wellcome.

Please reorder your patches into chunk that make sense standalone.

i.e. start with sending the new files under arch/i386/, then add the missing
hooks in arch/i386, then add one driver after another.  Then as last thing
we can discuss the ifdef mess you add all over the place :)

