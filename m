Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262361AbREUDGS>; Sun, 20 May 2001 23:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbREUDF6>; Sun, 20 May 2001 23:05:58 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:49413 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S262359AbREUDFx>;
	Sun, 20 May 2001 23:05:53 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: question: permission checking for network filesystem
Date: 21 May 2001 03:04:05 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9ea0j5$ik$1@abraham.cs.berkeley.edu>
In-Reply-To: <20010520172948.A27935@artax.karlin.mff.cuni.cz> <Pine.LNX.3.96.1010521001448.31037A-100000@artax.karlin.mff.cuni.cz>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 990414245 596 128.32.45.153 (21 May 2001 03:04:05 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 May 2001 03:04:05 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka  wrote:
>If you are checking permissions on server, read/execute have no security
>meaning.

This seems a bit too strong.  If I try to exec a file that has read
permission enabled but not execute permission, I'd like this to fail.
You can just imagine sysadmins who turn off exec bits on old buggy apps
to prevent users from executing them, who could get bit in the butt by
the sort of unexpected behavior that would result from ignoring execute
permission bits.
