Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129820AbRBYEVZ>; Sat, 24 Feb 2001 23:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbRBYEVP>; Sat, 24 Feb 2001 23:21:15 -0500
Received: from quechua.inka.de ([212.227.14.2]:27978 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129820AbRBYEVK>;
	Sat, 24 Feb 2001 23:21:10 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs: still problems with tail conversion
In-Reply-To: <878610000.983061717@tiny>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14WsgH-00006l-00@sites.inka.de>
Date: Sun, 25 Feb 2001 05:21:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <878610000.983061717@tiny> you wrote:
> Exactly.  The tail conversion code depends heavily on the page up to date
> bit being set right.  It is more than possible that I've screwed up
> something there, and the code thinks a page is valid when it really isn't.

I have seen null byte corruptions in syslog files with ext2 in various
kernels. So perhaps it is a general VFS problem?

Greetings
Bernd
