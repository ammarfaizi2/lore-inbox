Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313423AbSDLIB4>; Fri, 12 Apr 2002 04:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313428AbSDLIBz>; Fri, 12 Apr 2002 04:01:55 -0400
Received: from gymlit.lit.cz ([194.213.253.214]:51438 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S313423AbSDLIBw>;
	Fri, 12 Apr 2002 04:01:52 -0400
Date: Thu, 11 Apr 2002 16:23:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Byron Stanoszek <gandalf@winds.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using video memory as system memory
Message-ID: <20020411142303.GA120@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0204091816380.13516-100000@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Does the kernel support noncontiguous main memory like this, or is it just
> plain impossible to use PCI-mapped memory as main memory?

It might be possible (don't know why it does not work for you), but
bear in mind that PCI is *very* slow compared to your main memory.

[Oh, you might want to add that memory late in boot phase. At begining
of kernel boot, that area is probably not mapped, yet. PCI is
initialized later.]
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
