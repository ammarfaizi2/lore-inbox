Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132477AbRAPVBx>; Tue, 16 Jan 2001 16:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132463AbRAPVBo>; Tue, 16 Jan 2001 16:01:44 -0500
Received: from Cantor.suse.de ([194.112.123.193]:782 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132477AbRAPVBi>;
	Tue, 16 Jan 2001 16:01:38 -0500
Date: Tue, 16 Jan 2001 22:01:25 +0100
From: Andi Kleen <ak@suse.de>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116220125.A10985@gruyere.muc.suse.de>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116153757.A1609@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Tue, Jan 16, 2001 at 03:37:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 03:37:57PM -0500, Michael Meissner wrote:
> don't assume that the way your system gets booted is the way everybody's does,
> particularly those on platforms other than the x86.
> 
> I must say, as a 5 year Linux user (and 23 year UNIX user/administrator), I do
> get tired of having to hunt down and deal with each of these changes that come
> up from time to time with Linux (ie, switching from ipfwadm to ipchains to
> netfilter, or in this case reordering how scsi adapters/network adapters are
> looked up).

Bad example. 

netfilter does not force you to switch anything. You can just load the ipchains
or even the ipfw module and use your old scripts.

-Andi 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
