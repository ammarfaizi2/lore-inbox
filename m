Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263774AbTCUSn0>; Fri, 21 Mar 2003 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263765AbTCUSmR>; Fri, 21 Mar 2003 13:42:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263764AbTCUSlB>;
	Fri, 21 Mar 2003 13:41:01 -0500
Date: Fri, 21 Mar 2003 10:46:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: akpm@digeo.com, Linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: [PATCH] arch-independent syscalls to return long
Message-Id: <20030321104649.5d8f5c62.rddunlap@osdl.org>
In-Reply-To: <1048229509.2026.19.camel@phantasy.awol.org>
References: <3E7AAD0C.B8CB2926@verizon.net>
	<20030320222358.454a1f4f.akpm@digeo.com>
	<1048229509.2026.19.camel@phantasy.awol.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2003 01:51:50 -0500 Robert Love <rml@tech9.net> wrote:

| -extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
| +extern long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);

keep the asmlinkage (or why not?)


| -extern asmlinkage int sys_setsockopt(int fd, int level, int optname,
| -				     char *optval, int optlen);
| +extern long sys_setsockopt(int fd, int level, int optname,
| +			   char *optval, int optlen);

ditto

--
~Randy  [resending after error on first attempt]
