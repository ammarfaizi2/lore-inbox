Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTJYP6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 11:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTJYP6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 11:58:35 -0400
Received: from gandalf.tausq.org ([64.81.244.94]:3205 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S262691AbTJYP6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 11:58:34 -0400
Date: Sat, 25 Oct 2003 09:01:48 -0700
From: Randolph Chung <tausq@debian.org>
To: Art Haas <ahaas@airmail.net>
Cc: parisc-linux@parisc-linux.org, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] [PATCH] C99 cleanup in kernel/sysctl.c
Message-ID: <20031025160148.GC24406@tausq.org>
Reply-To: Randolph Chung <tausq@debian.org>
References: <20031025155107.GA2718@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025155107.GA2718@artsapartment.org>
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking at the file kernel/sysctl.c I saw this HP-PA specfic block of
> code. Here's an untested patch to format the code with C99 named
> initializers.

hm.. this is already in our 2.6 tree, except the old version was there
also, so we have two copies of the same sysctl.. oops :)

i've removed the redundant ones.

thanks
randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
