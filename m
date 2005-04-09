Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVDIPun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDIPun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVDIPum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 11:50:42 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:2190 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261263AbVDIPuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 11:50:39 -0400
Date: Sat, 9 Apr 2005 08:50:17 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ross@jose.lug.udel.edu, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409085017.7edf2c9a.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071720.GA23128@jose.lug.udel.edu>
	<Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in order to avoid having to worry about special characters
> they are NUL-terminated)

Would this be a possible alternative - newline terminated (convert any
newlines embedded in filenames to the 3 chars '%0A', and leave it as an
exercise to the reader to de-convert them.)

Line formatted ASCII files are really nice - worth pissing on embedded
newlines in paths to obtain.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
