Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbSLUJN0>; Sat, 21 Dec 2002 04:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbSLUJN0>; Sat, 21 Dec 2002 04:13:26 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:62432 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266854AbSLUJNZ>;
	Sat, 21 Dec 2002 04:13:25 -0500
Date: Sat, 21 Dec 2002 10:21:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Patrick Petermair <black666@inode.at>
Cc: Vojtech Pavlik <vojtech@suse.cz>, John Reiser <jreiser@BitWagon.com>,
       AnonimoVeneziano <voloterreno@tin.it>,
       Roland Quast <rquast@hotshed.com>, linux-kernel@vger.kernel.org
Subject: Re: vt8235 fix, hopefully last variant
Message-ID: <20021221102100.B29004@ucw.cz>
References: <20021219112640.A21164@ucw.cz> <200212202112.58475.black666@inode.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212202112.58475.black666@inode.at>; from black666@inode.at on Fri, Dec 20, 2002 at 09:12:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 09:12:58PM +0100, Patrick Petermair wrote:
> Hi!
> 
> Sorry for not replying this week, but I was not at home...now back to 
> business:
> 
> I tried the last patch, but it didn't work - I got Hunk messages:
> 
> starbase:/usr/src/linux-2.4.20# patch -p1 < vt8235-atapi 
> patching file drivers/ide/via82cxxx.c
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 141.
> Hunk #3 succeeded at 283 (offset -57 lines).
> 2 out of 3 hunks FAILED -- saving rejects to file 
> starbase:/usr/src/linux-2.4.20# 

Since they're in comments only, you can ignore them.

> MSI KT3Ultra2, TOSHIBA DVD-ROM SD-M1302
> So far my kernel is running your first patch and it works fine. Would 
> love to get the final patch running too, but I don't know what that 
> messages in via82cxxx.c.rej mean and how to modify the patch so that it 
> works - ah, btw: I tried to apply it to a clean 2.4.20 kernel source.

Sorry, then I probably made a mistake in generating it.

> Thanks so far for your great work.

Can you please try even when the first two hunks failed? Only the third
one really matters.

-- 
Vojtech Pavlik
SuSE Labs
