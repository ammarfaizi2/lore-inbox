Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUBVUvp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUBVUvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:51:45 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:58689 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261750AbUBVUvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:51:44 -0500
Date: Sun, 22 Feb 2004 12:53:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040222125312.11749dfd.pj@sgi.com>
In-Reply-To: <20040222155410.GA3051@hobbes>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, which shell expects the name of the script in argv[2]?

Which ones don't?  The burden is on you, not me. The Bourne like shells
that I happen to try just now _do_ display syntax error messages in
shell scripts with the name of the shell script file in the error
message.  Look and see how they are getting that script file name.

What's theoretical on one persons machine is very real and painful
on a million persons machines.  Incompatible changes in documented
interfaces have a high threshold to overcome.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
