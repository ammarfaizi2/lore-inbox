Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313845AbSDJVXM>; Wed, 10 Apr 2002 17:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313847AbSDJVXL>; Wed, 10 Apr 2002 17:23:11 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:21002 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S313845AbSDJVXK>; Wed, 10 Apr 2002 17:23:10 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: user-mode port 0.56-2.4.18-15
Date: 10 Apr 2002 21:14:10 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <a929v2$qg3$1@abraham.cs.berkeley.edu>
In-Reply-To: <20020408012536.A329@toy.ucw.cz> <200204092316.SAA05188@ccure.karaya.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1018473250 27139 128.32.45.153 (10 Apr 2002 21:14:10 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 10 Apr 2002 21:14:10 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike  wrote:
>pavel@suse.cz said:
>> Why don't you just feed your /dev/random from hosts /dev/random? 
>
>That would open up DOS attacks on the host.  A nasty person inside a UML
>could drain the host's /dev/random and hang anything on the host that needs
>random numbers.

Why not feed your /dev/random from the host's /dev/urandom?
