Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129648AbQKYTwq>; Sat, 25 Nov 2000 14:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129822AbQKYTwh>; Sat, 25 Nov 2000 14:52:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41488 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129648AbQKYTwZ>;
        Sat, 25 Nov 2000 14:52:25 -0500
Date: Sat, 25 Nov 2000 19:22:14 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: *_trylock return on success?
Message-ID: <20001125192214.R2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <00112516072500.01122@dox> <Pine.LNX.4.21.0011251547210.8818-100000@duckman.distro.conectiva> <20001125183036.Q2272@parcelfarce.linux.theplanet.co.uk> <00112520034902.01122@dox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <00112520034902.01122@dox>; from roger.larsson@norran.net on Sat, Nov 25, 2000 at 08:03:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 08:03:49PM +0100, Roger Larsson wrote:
> > _trylock functions return 0 for success.
> 
> Not   spin_trylock

Argh, I missed the (recent ?) change to make x86 spinlocks use 1 to mean
unlocked.  You're correct, and obviously this should be fixed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
