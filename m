Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280258AbRKIWxd>; Fri, 9 Nov 2001 17:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280262AbRKIWxX>; Fri, 9 Nov 2001 17:53:23 -0500
Received: from codepoet.org ([166.70.14.212]:19247 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280258AbRKIWxJ>;
	Fri, 9 Nov 2001 17:53:09 -0500
Date: Fri, 9 Nov 2001 15:53:10 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
Message-ID: <20011109155309.A14308@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <000201c16963$365e19e0$5101a8c0@pbc.adelphia.net> <Pine.LNX.4.33L.0111092030470.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0111092030470.2963-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 09, 2001 at 08:31:32PM -0200, Rik van Riel wrote:
> On Fri, 9 Nov 2001, Ben Israel wrote:
> 
> > Why does my 40 Megabyte per second IDE drive, transfer files at best
> > at 1-2 Megabytes per second?
> 
> Sounds like you're not using IDE DMA:
> 
> # hdparm -d1 /dev/hda
> 
> (not enabled by default because it corrupts data with some
> old chipsets and/or disks)

But wouldn't it make more sense to enable DMA by default, except 
for a set of blacklisted chipsets, rather then disabling it for 
everybody just because some older chipsets are crap?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
