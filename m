Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbREUKFd>; Mon, 21 May 2001 06:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262437AbREUKFX>; Mon, 21 May 2001 06:05:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8561 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262436AbREUKFQ>; Mon, 21 May 2001 06:05:16 -0400
Date: Mon, 21 May 2001 12:02:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521120228.J30738@athlon.random>
In-Reply-To: <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521112357.A1718@gruyere.muc.suse.de> <15112.57377.723591.710628@pizda.ninka.net> <20010521114216.A1968@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010521114216.A1968@gruyere.muc.suse.de>; from ak@suse.de on Mon, May 21, 2001 at 11:42:16AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 11:42:16AM +0200, Andi Kleen wrote:
> [actually most IA32 boxes already have one in form of the AGP GART, it's just
> not commonly used for serious things yet]

I can be really wrong on this because I didn't checked anything about
the GART yet but I suspect you cannot use the GART for this stuff on
ia32 in 2.4 because I think I recall it provides not an huge marging of
mapping entries that so would far too easily trigger the bugs in the
device drivers not checking for pci_map_* faliures also in a common
desktop/webserver/fileserver kind of usage of an high end machine.

Andrea
