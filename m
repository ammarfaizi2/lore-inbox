Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423783AbWJaSpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423783AbWJaSpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423785AbWJaSpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:45:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53007 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423783AbWJaSpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:45:53 -0500
Date: Tue, 31 Oct 2006 19:45:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061031184552.GS27968@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45477668.4070801@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:14:32AM -0800, Martin J. Bligh wrote:
> >But I've become innoculated against warnings, just because we have too 
> >many of the totally useless noise about deprecation and crud, and ppc has 
> >it's own set of bogus compiler-and-linker-generated warnings..
> >
> >At some point we should get rid of all the "politeness" warnings, just 
> >because they can end up hiding the _real_ ones.
> 
> Yay! Couldn't agree more. Does this mean you'll take patches for all the
> uninitialized variable crap from gcc 4.x ?
>...

Another approach might be to get the gcc -Wuninitialized option splitted 
into two different options ("is used uninitialized" and
"might be used uninitialized") and disable the latter.

> M.
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

