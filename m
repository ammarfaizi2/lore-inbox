Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275718AbRJAXka>; Mon, 1 Oct 2001 19:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275719AbRJAXkJ>; Mon, 1 Oct 2001 19:40:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37124 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275718AbRJAXkA>; Mon, 1 Oct 2001 19:40:00 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Date: Mon, 1 Oct 2001 16:40:05 -0700
Message-Id: <200110012340.QAA02719@sw170.transmeta.com>
To: alan@kernel.org, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: NFSv3 and linux-2.4.10-ac3 => oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I have a reproducible (and rather quick) oops on a system running
linux-2.4.10-ac3, which seems to be NFS (v3) related; although
ksymoops core dumps when I try to use it, I have manually decoded
the dump to indicate that it happens in rwsem_down_read_failed
called from nfs_file_wite.  Rather than posting too much here,
I have put as much information as I have been able to gather at:

ftp://ftp.zytor.com/pub/hpa/oops/

This includes the configuration, System.map, oops text etc.
