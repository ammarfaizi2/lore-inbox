Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278230AbRJSAPh>; Thu, 18 Oct 2001 20:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278229AbRJSAP2>; Thu, 18 Oct 2001 20:15:28 -0400
Received: from ns.suse.de ([213.95.15.193]:35851 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278227AbRJSAPS>;
	Thu, 18 Oct 2001 20:15:18 -0400
Date: Fri, 19 Oct 2001 02:15:30 +0200
From: Stefan Reinauer <stepan@suse.de>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch and Performance of larger pipes
Message-ID: <20011019021530.A796@suse.de>
In-Reply-To: <3BCF1A74.AE96F241@colorfullife.com> <E15uME1-0000Ht-00@bodnar42>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15uME1-0000Ht-00@bodnar42>
User-Agent: Mutt/1.3.22.1i
X-OS: Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ryan Cumming <bodnar42@phalynx.dhs.org> [011019 01:05]:
> Awesome! Although any improvement improvement in efficiency is a good thing, 
> I am curious as to what uses pipes besides gcc -pipe. UNIX domain sockets 
> (for local X11, for instance) aren't implemented as pipes, are they? What 
> sort of real world performance gains could I expect from this patch?

Shell scripts often use pipes to pass data between processes. Speed up should
be quite noticable with all kinds of those.

  Best regards
   Stefan Reinauer 
     <stepan@suse.de>

-- 
This world is crying to be free; This world is dying, can't you see?
We need a turn to do it right; We need a mind revolution
To get away from this selfishness. Stop playing blind - BREAK FREE!
					Your Turn, Helloween '91
