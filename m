Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTEHTdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTEHTdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:33:55 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:53178 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261989AbTEHTdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:33:54 -0400
Date: Thu, 8 May 2003 15:43:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305081546_MC3-1-3809-363F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Userspace
>       --- ptrace

  Ptrace appears to be effectively broken on 2.4.21-rc -- I can't strace
child processes that fork even as root, anyway.


> Block Layer
>       Loadable disk driver (Which can be made to stack)

  I'm sorry but I've been looking at the md code for about six months
and the 'big picture' of how it's doing what it does escapes me.  The
code in md.c:lock_rdev(), for example -- looks like an incredibly deep
understanding of how all the block code works is needed to write a
driver like this.
