Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281319AbRKVSJJ>; Thu, 22 Nov 2001 13:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281277AbRKVSIt>; Thu, 22 Nov 2001 13:08:49 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:26849 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281239AbRKVSIp>; Thu, 22 Nov 2001 13:08:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 18:08:43 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166xr9-0000Qy-00@mauve.csi.cam.ac.uk> <3BFD3C37.7C5BCCC4@starband.net>
In-Reply-To: <3BFD3C37.7C5BCCC4@starband.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166yHC-000153-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 5:56 pm, war wrote:
> This is incorrect.
> SWAP is used on a [1GB ram/2GB swap system].

As it should be. Page out unused data to make room for more cache. This 
*should* improve performance overall. (Yes, latency suffers to boost 
throughput. A fairly common tradeoff; you'll be glad of it under heavier 
load...)

You have "enough" RAM in that the machine doesn't crash under load, but NOT 
enough that swap would go unused.

> I talked to Rik about this.
> He said generally SWAP is a good thing and increases performance.
>
> However, in my case it does not.

As I've said, the VM doesn't always make the right choice :)


James.
