Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271028AbTGWRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271031AbTGWRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:33:09 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:19979 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S271028AbTGWRdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:33:07 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: 2.4.22-pre7: are security issues solved?
Date: Wed, 23 Jul 2003 17:47:59 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bfmhof$n1o$1@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain> <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au> <20030723033505.145db6b8.davem@redhat.com> <20030723104753.GA2479@gondor.apana.org.au>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1058982479 23608 128.32.153.211 (23 Jul 2003 17:47:59 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Wed, 23 Jul 2003 17:47:59 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu  wrote:
>On Wed, Jul 23, 2003 at 03:35:05AM -0700, David S. Miller wrote:
>> If I know your password is 7 characters I have a smaller
>> space of passwords to search to just brute-force it.
>
>It's much smaller if you didn't know that it was at most 7 characters
>long.

Yes, if I know I want to attack David Miller's password,
and I'm going to keep trying until I succeed, then knowing
the length of his password doesn't help much.  However, if
I'm on a multi-user system and I just want to crack any
password for any one of the users on that system, then
knowing the lengths of passwords does help, because I can
focus my effort on those users with the shortest passwords.
Thus, revealing password lengths might heighten the risk of
password guessing (even if only by a small factor).
