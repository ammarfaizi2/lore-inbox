Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291818AbSBHVMp>; Fri, 8 Feb 2002 16:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291813AbSBHVMg>; Fri, 8 Feb 2002 16:12:36 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:41477 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S291826AbSBHVMR>;
	Fri, 8 Feb 2002 16:12:17 -0500
Date: Fri, 8 Feb 2002 20:18:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read() from driverfs files can read more bytes
Message-ID: <20020208191824.GA561@elf.ucw.cz>
In-Reply-To: <1124DDDD7FF9@vcnet.vc.cvut.cz> <Pine.LNX.4.33.0202071021280.25114-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202071021280.25114-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ok, I agree with your argument concerning read(). 
> 
> Concerning reading/writing from offsets, it's up to the drivers for them 
> to either support it or not. In the files I've done so far, I return 0 if 
> show() is called with an offset. Which will give different results if you 
> read byte-by-byte or an entire chunk. 
> 
> It makes the callbacks simpler, but it is not technically correct. 

[snip solution]

Why not just say those files are character devices? It is okay for
character device to behave like crazy ;-).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
