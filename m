Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWCUGwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWCUGwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 01:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWCUGwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 01:52:07 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:3495 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751178AbWCUGwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 01:52:05 -0500
To: tytso@mit.edu
CC: uszhaoxin@gmail.com, viro@ftp.linux.org.uk, mingz@ele.uri.edu,
       mikado4vn@gmail.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20060320221911.GB11447@thunk.org> (message from Theodore Ts'o on
	Mon, 20 Mar 2006 17:19:11 -0500)
Subject: Re: Question regarding to store file system metadata in database
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com> <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com> <20060319194723.GA27946@ftp.linux.org.uk> <20060320130950.GA9334@thunk.org> <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com> <20060320221911.GB11447@thunk.org>
Message-Id: <E1FLai2-0001jF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Mar 2006 07:51:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not use a DB?  Because most databases's are big and bloated and
> not something you want to have in the kernel (not even Hans Reiser was
> crazy enough to propose stuffing an SQL interpreter into the kernel :-)
> --- and if you put the generic database (complete with SQL interpreter
> and all the rest) in userspace, doing upcalls into userspace, and then
> having to have the database interpret the SQL query, etc., takes time.
> 
> If you don't care about performance, by all means, try using FUSE and
> implementing a user-space filesystem.  It will be slow as all get-out,
> but maybe it won't matter for your application.

Something like this has already been done:

  http://www.noofs.org/

Miklos
