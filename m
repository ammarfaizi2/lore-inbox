Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265244AbSJRR2U>; Fri, 18 Oct 2002 13:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265329AbSJRR1u>; Fri, 18 Oct 2002 13:27:50 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:11502 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265244AbSJRRSa>; Fri, 18 Oct 2002 13:18:30 -0400
Date: Fri, 18 Oct 2002 15:24:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Russell Coker <russell@coker.com.au>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <200210181155.31274.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44L.0210181523410.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Russell Coker wrote:

> I agree with the point about not wanting to be converting between 32bit
> and 64bit for the LSM calls.  However I am not certain that we need to
> support both 32bit and 64bit interfaces to LSM on the same platform.

You'll only need to support it if you insist on keeping
sys_security in the kernel ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

