Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280238AbRKIWcW>; Fri, 9 Nov 2001 17:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280246AbRKIWcM>; Fri, 9 Nov 2001 17:32:12 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:44041 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280238AbRKIWb7>;
	Fri, 9 Nov 2001 17:31:59 -0500
Date: Fri, 9 Nov 2001 20:31:32 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ben Israel <ben@genesis-one.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Disk Performance
In-Reply-To: <000201c16963$365e19e0$5101a8c0@pbc.adelphia.net>
Message-ID: <Pine.LNX.4.33L.0111092030470.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Ben Israel wrote:

> Why does my 40 Megabyte per second IDE drive, transfer files at best
> at 1-2 Megabytes per second?

Sounds like you're not using IDE DMA:

# hdparm -d1 /dev/hda

(not enabled by default because it corrupts data with some
old chipsets and/or disks)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

