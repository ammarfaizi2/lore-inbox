Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265215AbRGAQrd>; Sun, 1 Jul 2001 12:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265214AbRGAQrW>; Sun, 1 Jul 2001 12:47:22 -0400
Received: from zeus.kernel.org ([209.10.41.242]:5090 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265208AbRGAQrM>;
	Sun, 1 Jul 2001 12:47:12 -0400
Date: Mon, 2 Jul 2001 04:42:52 +1200
To: Daniel Harvey <daniel@amristar.com.au>
Cc: linux-laptop@mobilix.org, linux-kernel@vger.kernel.org
Subject: Re: Linux SLOW on Compaq Armada 110 PIII Speedstep
Message-ID: <20010702044252.B14170@weta.f00f.org>
In-Reply-To: <NEBBJDBLILDEDGICHAGAEENECFAA.daniel@amristar.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NEBBJDBLILDEDGICHAGAEENECFAA.daniel@amristar.com.au>
User-Agent: Mutt/1.3.18i
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2001 at 11:36:51PM +0800, Daniel Harvey wrote:

> The Compaq Armada doesn't appear to have a BIOS setting for the
> power settings.

> I still don't get the fact that one kernel will run fast, while the
> rest do the real SLOW thing.

Not answering your question, but you might want to try:

Download the source-RPM for the 'fast' kernel, and also the virgin
version of the same kernel, and then diff them to see what changes
have been made.

If you are lucky, the RPM itself my have the virgin data and diffs, I
don't know much about RPMS, but I'm pretty sure this is possible.


You are looking for changes outside of linux/drivers/, probably in
linux/archo/i386 or linux/kernel. Hopefully there aren't too many of
these.

Also, you want the .config file that was used, try using that against
a virgin kernel first, and see if that changes anything, if not, then
do diff the above (diff -Nur virgin-kernel/ redhat-kernel/) and see
what falls out.



   --cw
