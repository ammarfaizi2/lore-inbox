Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbTCGUgC>; Fri, 7 Mar 2003 15:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbTCGUgC>; Fri, 7 Mar 2003 15:36:02 -0500
Received: from angband.namesys.com ([212.16.7.85]:15493 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261755AbTCGUgB>; Fri, 7 Mar 2003 15:36:01 -0500
Date: Fri, 7 Mar 2003 23:46:36 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] memleak in load_elf_binary?
Message-ID: <20030307234636.A3953@namesys.com>
References: <20030307141247.D7347@namesys.com> <20030307032532.17d37207.akpm@digeo.com> <20030307033609.2e7fd993.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307033609.2e7fd993.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 07, 2003 at 03:36:09AM -0800, Andrew Morton wrote:
> > This needs a little thought, as we've already set the new personality and the
> > old executable has been rubbed out.
> Actually it looks to be fairly simple to fix.   Less simple to test...

BTW, I just noticed that 2.4 have absolutely same problem it seems, so
you probably want to make fix for it too.

Bye,
    Oleg
