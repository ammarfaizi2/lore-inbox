Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267667AbTAXPOP>; Fri, 24 Jan 2003 10:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbTAXPOP>; Fri, 24 Jan 2003 10:14:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52999 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267667AbTAXPOO> convert rfc822-to-8bit; Fri, 24 Jan 2003 10:14:14 -0500
Date: Fri, 24 Jan 2003 10:20:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: User & <breno_silva@beta.bandnet.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Expand VM 
In-Reply-To: <20030123155627.M95099@beta.bandnet.com.br>
Message-ID: <Pine.LNX.3.96.1030124101905.13146A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, User & wrote:

> I have one idea , and this is about expand virtual memory on linux boxes 
> connected in LAN.
> Example: Linux A is processing come information , and need more memory , so 
> with this source , Linux A could access virtual memory on Linux B in LAN.
> But i don´t know how translate the virtual address between Linux A and B , to 
> have success in acess VM, or how to send all the process for Linux B to be 
> processed.
> 
> Any ideas ?

1 - NFS mount a big file and use that from swap space
2 - you could try the network block device stuff, at one time I believe I
had that working with RAID-1

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

