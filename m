Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUBWFqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUBWFqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:46:21 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:53880 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261824AbUBWFqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:46:20 -0500
Date: Sun, 22 Feb 2004 21:42:55 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: linux-kernel@vger.kernel.org, hjlipp@web.de
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040222214255.0a6488c7.pj@sgi.com>
In-Reply-To: <20040216133418.GA4399@hobbes>
References: <20040216133418.GA4399@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  #!/usr/bin/awk -F \t -f

If your primary need is to set the awk field separator, how about
setting FS (or IFS, depending on which awk) in a BEGIN section
in the script?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
