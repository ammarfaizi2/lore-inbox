Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTARFe7>; Sat, 18 Jan 2003 00:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTARFe6>; Sat, 18 Jan 2003 00:34:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S262580AbTARFe6>;
	Sat, 18 Jan 2003 00:34:58 -0500
Date: Sat, 18 Jan 2003 00:45:04 -0500
From: Christopher Faylor <cgf@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Message-ID: <20030118054504.GA909@redhat.com>
References: <15911.64825.624251.707026@harpo.it.uu.se> <Pine.LNX.4.44.0301171808010.15056-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301171808010.15056-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 06:11:01PM -0600, Kai Germaschewski wrote:
>On Fri, 17 Jan 2003, Mikael Pettersson wrote:
>
>> This oops occurs for every module, not just af_packet.ko, at
>> resolve_symbol()'s first call to __find_symbol().
>
>Okay, the details I received so far seem to indicate that the appended 
>patch will fix it, though I didn't get actual confirmation it does.
>
>If you experience crashes when loading modules (and have RH 8 binutils), 
>please give it a shot.

It isn't a scientific test since I also just added the 2.5.59-mm1
patches, but applying this patch seemed to fix my problems.  I'm sending
this from a kernel running 2.5.59 + mm1 + your patch, built with RH 8.0
binutils.

cgf
