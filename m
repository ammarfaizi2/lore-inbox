Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbRL1Ucv>; Fri, 28 Dec 2001 15:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287008AbRL1Uck>; Fri, 28 Dec 2001 15:32:40 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:44295 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287003AbRL1Uc0>; Fri, 28 Dec 2001 15:32:26 -0500
Date: Fri, 28 Dec 2001 18:32:12 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C2CD326.100@athlon.maya.org>
Message-ID: <Pine.LNX.4.33L.0112281827000.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Andreas Hartmann wrote:

> 	Fix the VM-management in kernel 2.4.x. It's unusable. Believe
> 	me! As comparison: kernel 2.2.19 didn't need nearly any swap for
> 	the same operation!

If you feel adventurous you can try my rmap based
VM, the latest version is on:

	http://surriel.com/patches/2.4/2.4.17-rmap-8

This VM should behave a bit better (it does on my machines),
but isn't yet bug-free enough to be used on production machines.
Also, the changes it introduces are, IMHO, too big for a stable
kernel series ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

