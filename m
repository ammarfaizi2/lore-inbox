Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284052AbRLAKkN>; Sat, 1 Dec 2001 05:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284053AbRLAKkE>; Sat, 1 Dec 2001 05:40:04 -0500
Received: from [194.213.32.133] ([194.213.32.133]:3200 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S284052AbRLAKjy>;
	Sat, 1 Dec 2001 05:39:54 -0500
Date: Thu, 29 Nov 2001 23:21:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011129232157.A211@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <01112715312104.01486@localhost> <20011128194302.A29500@emma1.emma.line.org> <01112813462404.01163@driftwood> <20011128231925.A7034@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011128231925.A7034@emma1.emma.line.org>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Assuming the drive's inherent bad-block detection mechanisms don't find it 
> > and remap it on a read first, rapidly consuming the spare block reserve.  But 
> > that's a firmware problem...
> 
> Drives should never reassign blocks on read operations, because they'd
> take away the chance to try to read that block for say four hours.

Why not? If drive gets ECC-correctable read error, it seems to me like
good time to reassign.
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
