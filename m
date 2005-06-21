Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVFUU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVFUU26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFUU07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:26:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:51915 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262315AbVFUUZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:25:30 -0400
Date: Tue, 21 Jun 2005 22:25:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: nanakos@wired-net.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 sendfile
Message-ID: <20050621202529.GC19562@wohnheim.fh-wedel.de>
References: <50773.62.38.141.127.1119357138.squirrel@webmail.wired-net.gr> <20050621125243.GA7139@wohnheim.fh-wedel.de> <39281.62.38.143.212.1119384443.squirrel@webmail.wired-net.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39281.62.38.143.212.1119384443.squirrel@webmail.wired-net.gr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 June 2005 23:07:23 +0300, nanakos@wired-net.gr wrote:
> 
> Very interesting patches,but what i need to is a pacth or some points so i
> can change the existing source code according to my needs.Can someone help
> me on that?
> The existing sendfile system call copies data from a file descriptor to a
> socket descriptor.I have already a program that i have to port that uses
> the sendfile syscall from 2.4.x series kernels.In 2.6.x doesnt work.What
> are the minimal changes that have to be done so i can use again the
> syscall in 2.6.x kernel's???

The first two patches (generic_sendpage.patch and sendfile.patch)
should be all you need.  But they were rather quick hack and I haven't
seriously looked at them for quite a while.

Maybe I should change that.  Several people appear to be generally
interested in the subject.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
