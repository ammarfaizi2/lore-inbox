Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSHNMQT>; Wed, 14 Aug 2002 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSHNMQT>; Wed, 14 Aug 2002 08:16:19 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:8976 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317341AbSHNMQS>; Wed, 14 Aug 2002 08:16:18 -0400
Date: Wed, 14 Aug 2002 13:20:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: linux-kernel@vger.kernel.org
Subject: S390 vs S390x, was Re: [kbuild-devel] Re: [patch] kernel config 3/N - move sound into drivers/media
Message-ID: <20020814132011.A13932@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org
References: <20020814043558.GN761@cadcamlab.org> <Pine.LNX.4.44.0208132342560.32010-100000@chaos.physics.uiowa.edu> <20020814054945.GO761@cadcamlab.org> <200208141256.27680.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208141256.27680.arnd@bergmann-dalldorf.de>; from arnd@bergmann-dalldorf.de on Wed, Aug 14, 2002 at 12:56:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 12:56:27PM +0200, Arnd Bergmann wrote:
> It's not logical, but it tends to help because it's what's meant most
> of the time. I don't know a single place in the kernel where you want
> to test for (CONFIG_ARCH_S390 && !CONFIG_ARCH_S390X).

BTW, ho much differences are between arch/s390 and arch/s390x?  Is there
any chance it could use the same #ifdef __LP64__ trick parisc uses for
its 32 and 64bit versions?  so far every file I've looked at was duplicated
exactly in s390 and s390x.

