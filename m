Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSEKOK5>; Sat, 11 May 2002 10:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316222AbSEKOK4>; Sat, 11 May 2002 10:10:56 -0400
Received: from vitelus.com ([64.81.243.207]:9738 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S316221AbSEKOK4>;
	Sat, 11 May 2002 10:10:56 -0400
Date: Sat, 11 May 2002 07:09:52 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
Message-ID: <20020511140952.GB6102@vitelus.com>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CD7BA24.9050205@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 01:27:32PM +0200, Martin Dalecki wrote:
> Tue May  7 02:37:49 CEST 2002 ide-clean-57
> 
> Nuke /proc/ide.

I actually agree with you here. /proc has turned into a bloated mess
of unparsable text files. It would be nice if we could move some of
this information to a uniform sysctl() interface. I hope you'll work a
bit on that (if it isn't already implemented!).
