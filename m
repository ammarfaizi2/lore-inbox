Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUBWWIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUBWWIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:08:12 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:54944 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262064AbUBWWIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:08:06 -0500
Date: Mon, 23 Feb 2004 14:08:05 -0800
From: Paul Jackson <pj@sgi.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223140805.00445f62.pj@sgi.com>
In-Reply-To: <20040223201631.GA32584@mail.shareable.org>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
	<20040222214457.6f8d2224.pj@sgi.com>
	<20040223142215.GB30321@mail.shareable.org>
	<20040223121205.2ef329fd.pj@sgi.com>
	<20040223201631.GA32584@mail.shareable.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Therefore the shell behaviour is not relevant, except for such scripts.

So we agree that the shell behaviour is relevant for such scripts.

I don't think I missed a thing, and I think we are in agreement, except
on the relative value of this change, versus the risk of breaking a
shell.

If a shell is coded to allow for at most one option before the script
file path, and if a script is presented to it with a shebang option
having an embedded space, then ... oops.

You're just discounting the risk of either such scripts or of such
stupidly coded shells more than I am discounting such, and you are
valuing the usefulness of the proposed change more than I value it.

I accept that there is no shell, nor script, on your system that would
break, and to be honest, I can't find any such shell, or script, on my
system either.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
