Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSKDVN4>; Mon, 4 Nov 2002 16:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSKDVN4>; Mon, 4 Nov 2002 16:13:56 -0500
Received: from pc132.utati.net ([216.143.22.132]:65408 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262792AbSKDVKO> convert rfc822-to-8bit; Mon, 4 Nov 2002 16:10:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Cort Dougan <cort@fsmlabs.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: CONFIG_TINY
Date: Mon, 4 Nov 2002 16:16:48 +0000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021030233605.A32411@jaquet.dk> <20021104195005.GB27298@opus.bloom.county> <20021104133420.E20427@duath.fsmlabs.com>
In-Reply-To: <20021104133420.E20427@duath.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211041616.48602.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 November 2002 20:34, Cort Dougan wrote:
> I'm with you on that.  People who clammer ignorantly about image size
> without looking at what they actually need should have opened their eyes in
> the last few years.  Flash and RAM sizes under 32M are nearly unheard of
> now-a-days.

How much power does flash eat?  I was under the impression half the reason for 
tiny amounts of memory was to increase battery life in things that really 
should last weeks or months instead of hours (wristwatches, cell phones on 
standby, etc), but I guess that's mostly a question of dram and sram, not 
flash.  (I take it you can read the heck out of it without wearing it out, 
it's just writes that are a problem...  Then again you don't want rapidly 
rewritten bookkeeping stuff in flash, do you?  (Jiffies, scheduler stuff, 
etc, should not be in flash...))

Not my area, I'm afraid...

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
