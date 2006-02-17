Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWBQPTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWBQPTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWBQPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:19:40 -0500
Received: from [195.23.16.24] ([195.23.16.24]:5568 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751467AbWBQPTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:19:40 -0500
Message-ID: <43F5E988.1070306@grupopie.com>
Date: Fri, 17 Feb 2006 15:19:36 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: fix singlestepping though a syscall
References: <200602170320_MC3-1-B898-C9D3@compuserve.com>
In-Reply-To: <200602170320_MC3-1-B898-C9D3@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>[...]
> Yes, that works.  I was afraid to try it because of unknown side-effects
> but one of those may be that it fixes Paolo's debugger problem.  The C
> program I was testing with is enclosed and I can even (with care) debug
> it with gdb passing through SIGTRAP and step through the signal handler.
> 
> Paolo, can you try this patch for your debugger problem?
     ^
Paulo, please ;)

Humm.... I've already found a way to make the debugger work (see th 
other thread) and at a first glance it seems unrelated to this. So I 
suspect I wouldn't gain much by testing it.

If you think it is worth doing it anyway, it won't be that much trouble 
to test yet another kernel, so I can certainly do it tonight...

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
