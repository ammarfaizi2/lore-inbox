Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUBWWAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUBWWAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:00:31 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:4248 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262003AbUBWWA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:00:29 -0500
Date: Mon, 23 Feb 2004 14:00:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223140027.5c035157.pj@sgi.com>
In-Reply-To: <20040223202524.GC13914@hobbes>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
	<20040222214457.6f8d2224.pj@sgi.com>
	<20040223202524.GC13914@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hansjoerg wrote:
> I still don't understand your argument... If there is a shell having
> those problems, nobody would use something like

I will acknowledge that while one _could_ code a shell so that your
proposed change would break it, it would be a stupid, silly and ugly
way to code a shell.

That is, one _could_ code a shell to say:

 1) If argv[1] starts with a '-', consume and handle as an option
    (or possibly as a space separated list of options).
 2) Presume the next argument, if any, is a shell script file.

I would be surprised if any of the major shells are coded this way.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
