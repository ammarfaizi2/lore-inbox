Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTA2Pgc>; Wed, 29 Jan 2003 10:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTA2Pgc>; Wed, 29 Jan 2003 10:36:32 -0500
Received: from mail.ithnet.com ([217.64.64.8]:52497 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265140AbTA2Pgb>;
	Wed, 29 Jan 2003 10:36:31 -0500
Date: Wed, 29 Jan 2003 16:45:52 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no more MTRRs available ?
Message-Id: <20030129164552.182e0cb8.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0301291025240.18828-100000@coffee.psychology.mcmaster.ca>
References: <20030129162354.55f2ace4.skraw@ithnet.com>
	<Pine.LNX.4.44.0301291025240.18828-100000@coffee.psychology.mcmaster.ca>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003 10:25:57 -0500 (EST)
Mark Hahn <hahn@physics.mcmaster.ca> wrote:

> > what exactly does
> > 
> > 	mtrr: no more MTRRs available
> > 	mtrr: no more MTRRs available
> > 
> > during boot mean? What can I do against this? This comes up while booting a
> > system with 6GB and P-III 1.4 GHz (Serverworks chipset). Kernel is 2.4.20.
> 
> you need to look at /proc/mtrr.

Thanks for your hint, but what does this tell me?

# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
reg04: base=0xf0000000 (3840MB), size= 128MB: write-back, count=1
reg05: base=0xf7000000 (3952MB), size=  16MB: uncachable, count=1
reg06: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
reg07: base=0x200000000 (8192MB), size=8192MB: write-back, count=1
 
-- 
Regards,
Stephan
