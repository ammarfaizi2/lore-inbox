Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136706AbREAUCl>; Tue, 1 May 2001 16:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136707AbREAUCb>; Tue, 1 May 2001 16:02:31 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:9992 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S136706AbREAUCT>; Tue, 1 May 2001 16:02:19 -0400
Date: Tue, 1 May 2001 16:02:16 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Seth Goldberg <bergsoft@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <3AEF1122.B543098E@home.com>
Message-ID: <Pine.LNX.4.10.10105011558310.17091-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   And that's exactly what I did :)...  I found that ONLY the combination
> of USE_3DNOW and forcing the athlon mmx stuff in (by doing #if 1 in
> results in this wackiness.  I should alos repeat that I *DO* see that

I doubt that USE_3DNOW is causing the problem, but rather when you
USE_3DNOW, the kernel streams through your northbridge at roughly
twice the bandwidth.  if your dram settings are flakey, this could
eaily trigger a problem.  

this has nothing to do with the very specific disk corruption
being discussed (which has to do with the ide controller, according
to the most recent rumors.).

>   The other thing i was gunna try is to dump my chipset registers using 
> WPCREDIT and WPCRSET and compare them with other people on this list

why resort to silly windows tools, when lspci under Linux does it for you?

regards, mark hahn.

