Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284334AbRLMQzy>; Thu, 13 Dec 2001 11:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284359AbRLMQzo>; Thu, 13 Dec 2001 11:55:44 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:63892 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S284334AbRLMQzg>; Thu, 13 Dec 2001 11:55:36 -0500
Date: Thu, 13 Dec 2001 08:54:57 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
In-Reply-To: <Pine.LNX.4.33.0112130803260.19406-100000@mf1.private>
Message-ID: <Pine.LNX.4.33.0112130854170.19629-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Wayne Whitney wrote:

> The app per se does not call mmap(), but mmap() is called once when I
> execute it.

Correction:  strace shows that it is called many times during startup, but
only once without a corresponding munmap()>

Wayne


