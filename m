Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279244AbRJWFZR>; Tue, 23 Oct 2001 01:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279245AbRJWFZH>; Tue, 23 Oct 2001 01:25:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:59140 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279244AbRJWFYz>;
	Tue, 23 Oct 2001 01:24:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
        BitKeeper Development Source <dev@bitmover.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch 
In-Reply-To: Your message of "Mon, 22 Oct 2001 10:12:12 MST."
             <20011022101212.B24778@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Oct 2001 15:25:06 +1000
Message-ID: <1222.1003814706@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 10:12:12 -0700, 
Larry McVoy <lm@bitmover.com> wrote:
>The basic idea being that we first of all narrow the race window and
>second of all detect the race in all cases where the mods to the dir
>result in either a changed mtime or a changed size.

Aren't there some file systems where the directory size is always 0?  I
vaguely remember a change to make mrproper to work round that "feature".

