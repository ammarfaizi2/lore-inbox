Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUBWFne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUBWFne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:43:34 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:37748 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261819AbUBWFnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:43:32 -0500
Date: Sun, 22 Feb 2004 21:44:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040222214457.6f8d2224.pj@sgi.com>
In-Reply-To: <20040222225750.GA27402@mail.shareable.org>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe the question was "which shell expects the name in argv[2]

The question is more like: examine each shell's argument parsing code to
determine which ones will or will not be affected by this.  For a change
like this, someone needs to actually look at the code for each major
shell, and verify their reading of the code with a little experimentation.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
