Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbREMT2C>; Sun, 13 May 2001 15:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbREMT1x>; Sun, 13 May 2001 15:27:53 -0400
Received: from ns.caldera.de ([212.34.180.1]:43954 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261747AbREMT1u>;
	Sun, 13 May 2001 15:27:50 -0400
Date: Sun, 13 May 2001 21:25:49 +0200
From: Christoph Hellwig <hch@caldera.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
Message-ID: <20010513212549.A30308@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
	linux-kernel@vger.kernel.org, mge@sistina.com
In-Reply-To: <15100.37367.477922.66043@pizda.ninka.net> <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu> <20010511171124.M30355@athlon.random> <15100.18375.367656.3591@pizda.ninka.net> <20010512032453.A8259@athlon.random> <15100.37367.477922.66043@pizda.ninka.net> <23605.989775371@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23605.989775371@redhat.com>; from dwmw2@infradead.org on Sun, May 13, 2001 at 06:36:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 06:36:11PM +0100, David Woodhouse wrote:
> IMHO, no 64-bit architecture code should provide translation functions for
> ioctls from 32-bit binaries.
> 
> This is now a sufficiently common requirement that it shouldn't be repeated 
> by all architectures that require it - it should be somewhere common.
> Like linux/abi/ioctl32/

Better linux/abi/linux32 and have other 32/64-bit stuff there too.
At least the binfmt_elf32 stuff should be made MI, IMHO.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
