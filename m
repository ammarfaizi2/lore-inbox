Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271722AbRICObF>; Mon, 3 Sep 2001 10:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271723AbRICOa4>; Mon, 3 Sep 2001 10:30:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8712 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S271722AbRICOar>;
	Mon, 3 Sep 2001 10:30:47 -0400
Date: Mon, 3 Sep 2001 15:31:04 +0100
From: Matthew Wilcox <willy@debian.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
        alan@lxorguk.ukuu.org.uk, willy@debian.org, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010903153104.H5126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <E15dghq-0000bZ-00@the-village.bc.nu.suse.lists.linux.kernel> <oup66b0zq9j.fsf@pigdrop.muc.suse.de> <20010903.011530.62340995.davem@redhat.com> <20010903104105.A3398@gruyere.muc.suse.de> <3B935FF8.935244CE@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B935FF8.935244CE@namesys.com>; from reiser@namesys.com on Mon, Sep 03, 2001 at 02:48:24PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 02:48:24PM +0400, Hans Reiser wrote:
> Ok, so the sum of this is that Jeff's patches work on the platforms he wrote
> them for, and we need one more fix for PA-RISC.
> 
> So, we can reasonably send Jeff's patches to Linus, and test and then put the
> PA-RISC patch into the AC tree, any disagreement?

If you don't align on sparc, alpha, et al, then it will be slower than
it could be; don't you want to fix that first?

-- 
Revolutions do not require corporate support.
