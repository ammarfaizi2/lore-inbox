Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbRF0AyR>; Tue, 26 Jun 2001 20:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbRF0AyI>; Tue, 26 Jun 2001 20:54:08 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:2574 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S265179AbRF0Axv>;
	Tue, 26 Jun 2001 20:53:51 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] User chroot
Date: 27 Jun 2001 00:51:32 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9hbamk$dnp$1@abraham.cs.berkeley.edu>
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D1205FB@nasdaq.ms.ensim.com> <E15F3KH-0003fd-00@pmenage-dt.ensim.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 993603092 14073 128.32.45.153 (27 Jun 2001 00:51:32 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 27 Jun 2001 00:51:32 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage  wrote:
>It could potentially be useful for a network daemon (e.g. a simplified
>anonymous FTP server) that wanted to be absolutely sure that neither it
>nor any of its libraries were being tricked into following a bogus
>symlink, or a "/../" in a passed filename. After initialisation, the
>daemon could chroot() into its data directory, and safely only serve
>the set of files within that directory hierarchy.
>
>This could be regarded as the wrong way to solve such a problem, but
>this kind of bug seems to be occurring often enough on BugTraq that it
>might be useful if you don't have the resources to do a full security
>audit on your program (or if the source to some of your libraries
>isn't available).

Or even where you have done a full security audit on your program, it is
often still useful to have backup protection.  Belt and suspenders[*],
and all that.

[*] For those who are not familiar with the reference: If you really,
    really want to avoid getting caught with your pants down, you might
    wear both a belt and a pair of suspenders.
