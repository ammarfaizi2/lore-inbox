Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUBWVzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUBWVzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:55:14 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:48018 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262052AbUBWVzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:55:10 -0500
Date: Mon, 23 Feb 2004 13:55:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223135510.61bcc893.pj@sgi.com>
In-Reply-To: <20040223202425.GB13914@hobbes>
References: <20040216133418.GA4399@hobbes>
	<20040222214255.0a6488c7.pj@sgi.com>
	<20040223202425.GB13914@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hansjoerg wrote:
> But what about
> #!/usr/bin/awk --posix -f

What I would actually code, in this case, and as I just noted a minute
ago in a parallel rely, would be:

  #!/bin/sh
  awk --posix -f '
    ...
  '

I basically never put awk in the shebang line.  Rather I invoke it on
quoted scripts inside of a shell script.  This habit has served me well
for some 25 years now, on a variety of systems.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
