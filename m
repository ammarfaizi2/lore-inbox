Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266871AbRGFWFP>; Fri, 6 Jul 2001 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266872AbRGFWFI>; Fri, 6 Jul 2001 18:05:08 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:58887 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S266871AbRGFWEz>;
	Fri, 6 Jul 2001 18:04:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] more SAK stuff
Date: 6 Jul 2001 22:02:09 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9i5ch1$p8u$1@abraham.cs.berkeley.edu>
In-Reply-To: <UTC200107021216.OAA512638.aeb@vlet.cwi.nl>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 994456929 25886 128.32.45.153 (6 Jul 2001 22:02:09 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 6 Jul 2001 22:02:09 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>More interestingly, it changes the operation of SAK in two ways:
>(a) It does less, namely will not kill processes with uid 0.

I think this is bad for security.

(I assume you meant euid 0, not ruid 0.  Using the real uid
for access control decisions is a very odd thing to do.)
