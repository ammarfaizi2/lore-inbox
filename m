Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289834AbSAKCs0>; Thu, 10 Jan 2002 21:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSAKCsR>; Thu, 10 Jan 2002 21:48:17 -0500
Received: from nrg.org ([216.101.165.106]:58162 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S289834AbSAKCsB>;
	Thu, 10 Jan 2002 21:48:01 -0500
Date: Thu, 10 Jan 2002 18:47:45 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16OkSV-0005EZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201101840470.5213-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Alan Cox wrote:
> The fun below 1mS comes from
>
> 	1.	APM bios calls where the bios decides to take >1mS to have
> 		a chat with your batteries
> 	2.	Video cards pulling borderline legal PCI tricks to get
> 		better benchmarketing by stalling the entire bus

Don't forget the embedded space, where the hardware vendor can ensure
that their hardware is well-behaved.  Even on a PC, it is possible for
someone who cares about realtime to spec a reasonable system.

On good hardware, we can easily do much better than 1ms latency with a
preemptible kernel and a spinlock cleanup.  I don't think the
limitations of some PC hardware should limit our goals for Linux.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

