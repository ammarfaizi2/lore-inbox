Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282585AbRKZVzC>; Mon, 26 Nov 2001 16:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282590AbRKZVym>; Mon, 26 Nov 2001 16:54:42 -0500
Received: from ns.caldera.de ([212.34.180.1]:2758 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S282585AbRKZVyh>;
	Mon, 26 Nov 2001 16:54:37 -0500
Date: Mon, 26 Nov 2001 22:51:53 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Wolfgang Rohdewald <WRohdewald@dplanet.ch>
Cc: Christopher Friesen <cfriesen@nortelnetworks.com>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Subject: Re: [Linux-abi-devel] Re: Swap
Message-ID: <20011126225153.B17424@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Wolfgang Rohdewald <WRohdewald@dplanet.ch>,
	Christopher Friesen <cfriesen@nortelnetworks.com>,
	root@chaos.analogic.com, linux-kernel@vger.kernel.org,
	linux-abi-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com> <3BFA8F87.9FB4C13E@nortelnetworks.com> <20011120175804.30794332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120175804.30794332@localhost.localdomain>; from WRohdewald@dplanet.ch on Tue, Nov 20, 2001 at 06:58:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 06:58:03PM +0100, Wolfgang Rohdewald wrote:
> I am quite sure this is also possible if the binary is emulated by
> the linux-abi modules like my old SCO binaries.

Linux-ABI mmaps binaries if they are page-aligned, otherwise they
are read completly at startup.  Note that Linux-ABI uses the normal
binfmt_elf for foreign ELF binaries, so the above applies only
to COFF and X.out (Microsoft x.out) binaries.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
