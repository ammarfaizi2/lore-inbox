Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbUBWX7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUBWX7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:59:34 -0500
Received: from mail.shareable.org ([81.29.64.88]:42882 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262098AbUBWX7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:59:33 -0500
Date: Mon, 23 Feb 2004 23:59:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Paul Jackson <pj@sgi.com>
Cc: Hansjoerg Lipp <hjlipp@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040223235924.GB1277@mail.shareable.org>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com> <20040223202524.GC13914@hobbes> <20040223140027.5c035157.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223140027.5c035157.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>  1) If argv[1] starts with a '-', consume and handle as an option
>     (or possibly as a space separated list of options).
>  2) Presume the next argument, if any, is a shell script file.
> 
> I would be surprised if any of the major shells are coded this way.

It would have been a "smart" thing for Perl to do, extra friendly for
programmers, auto-configuring with a test at installation time of
course.  I doubt Perl does that but it wouldn't surprise me - it seems
like quite a good idea - Perl scripts using the capability would even
be portable :)

-- Jamie
