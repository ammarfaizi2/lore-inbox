Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVBHXJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVBHXJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVBHXJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:09:53 -0500
Received: from hera.kernel.org ([209.128.68.125]:55983 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261681AbVBHXJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:09:49 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Date: Tue, 8 Feb 2005 23:09:31 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cubgrb$39e$1@terminus.zytor.com>
References: <4205AC37.3030301@comcast.net> <20050207004218.GA12541@ojjektum.uhulinux.hu> <20050207024800.GA18010@hobbes.itsari.int> <20050207084709.GA30680@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107904171 3375 127.0.0.1 (8 Feb 2005 23:09:31 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 8 Feb 2005 23:09:31 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050207084709.GA30680@ojjektum.uhulinux.hu>
By author:    =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
In newsgroup: linux.dev.kernel
> 
> Granted, I could override the default order by using a /etc/filesystems 
> file. But the kernel should have a much more sane default on its own, 
> namely "try vfat before msdos".
> 

What it really means is that mount(8) should know this is a special
case; presumably it already knows to try ext3 over ext2.

	-hpa

