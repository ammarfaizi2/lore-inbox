Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbTCFCqr>; Wed, 5 Mar 2003 21:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTCFCqr>; Wed, 5 Mar 2003 21:46:47 -0500
Received: from [208.48.139.185] ([208.48.139.185]:15030 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S267697AbTCFCqq>; Wed, 5 Mar 2003 21:46:46 -0500
Date: Wed, 5 Mar 2003 18:57:13 -0800
From: David Rees <dbr@greenhydrant.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux vs Windows temperature anomaly
Message-ID: <20030305185713.B23061@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0303041434220.1438-100000@localhost.localdomain> <20030305205032.GD2958@atrey.karlin.mff.cuni.cz> <p05210507ba8c20241329@[10.2.0.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p05210507ba8c20241329@[10.2.0.101]>; from linux@lundell-bros.com on Wed, Mar 05, 2003 at 01:52:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 01:52:16PM -0800, Jonathan Lundell wrote:
> We've been seeing a curious phenomenon on some PIII/ServerWorks 
> CNB30-LE systems.
> 
> The systems fail at relatively low temperatures. While the failures 
> are not specifically memory related (ECC errors are never a factor), 
> we have a memory test that's pretty good at triggering them. Data is 
> apparently getting corrupted on the front-side bus.
> 
> Here's the curious thing: when we run the same memory test on a 
> Windows 2000 system (same hardware; we just swap the disk), we can 
> run the ambient temperature up to 60C with no problem at all; the 
> test will run for days. (It occurred to us to try Win2K because the 
> hardware vendor was using it to test systems at temperature without 
> seeing problems.)
> 
> Swap in the Linux disk, and at that temperature it'll barely run at 
> all. The memory test fails quickly at 40C ambient.
> 
> FWIW, CPU cooling is pretty good in this box.
> 
> So, the puzzle: what might account for temperature sensitivity, of 
> all things, under Linux 2.4.9-31 (RH 7.2), but not Win2K?

Since it doesn't sound like this is a memory error, but a chipset driver
error it could be a Linux driver bug.

You are running a very old kernel, at the least upgrade to the latest
errata (which is currently 2.4.18-26.7.  You are running the latest
security updates as well, right?

-Dave
