Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUACU5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 15:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbUACU5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 15:57:04 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:34690 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264113AbUACU4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 15:56:54 -0500
Date: Sat, 3 Jan 2004 21:56:42 +0100
From: Tobias Diedrich <ranma@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Message-ID: <20040103205642.GA517@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <3FF5B3AB.5020309@wmich.edu> <200401022200.22917.ornati@lycos.it> <20040103033327.GA413@melchior.yamamaya.is-a-geek.org> <200401030415.i034FJoc006230@turing-police.cc.vt.edu> <20040103133945.GB396@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103133945.GB396@melchior.yamamaya.is-a-geek.org>
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://studserv.stud.uni-hannover.de/~ranma/gpg-key
User-Agent: Mutt/1.5.4i
X-Seen: false
X-ID: b7Xs7uZpgeUX8ncKJUQDQ4U6HRCw1OeMJ5zx8Iyz5lAnge8RKEeS4S@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> Valdis.Kletnieks@vt.edu wrote:
> 
> > 'cat' is probably doing a stat() on stdout and seeing it's connected
> > to /dev/null and not even bothering to do the write() call.  I've seen
> > similar behavior in other GNU utilities.
> 
> I can't see any special casing for /dev/null in cat's source, but I
> forgot to check dd with bigger block size. It's ok with bs=4096...

However with 2.4 dd performs fine even with bs=512.

-- 
Tobias						PGP: http://9ac7e0bc.2ya.com
Be vigilant!
np: PHILFUL3
