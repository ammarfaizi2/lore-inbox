Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRBUBE5>; Tue, 20 Feb 2001 20:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131268AbRBUBEh>; Tue, 20 Feb 2001 20:04:37 -0500
Received: from quechua.inka.de ([212.227.14.2]:17758 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131254AbRBUBEe>;
	Tue, 20 Feb 2001 20:04:34 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <01022100361408.18944@gimli>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14VNhp-0000Bf-00@sites.inka.de>
Date: Wed, 21 Feb 2001 02:04:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01022100361408.18944@gimli> you wrote:
> But actually, rm is not problem, it's open and create.  To do a
> create you have to make sure the file doesn't already exist, and
> without an index you have to scan on average half the directory file. 

Unless you use a File System which is better for that, like Reiser-FS. Of
course a even better solution is to distribute those files in hashed subdirs.

Greetings
Bernd
