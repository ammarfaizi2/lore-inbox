Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318456AbSGSDfq>; Thu, 18 Jul 2002 23:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318457AbSGSDfq>; Thu, 18 Jul 2002 23:35:46 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:46086 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S318456AbSGSDfp>; Thu, 18 Jul 2002 23:35:45 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: more thoughts on a new jail() system call
Date: 19 Jul 2002 03:23:04 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ah80mo$53t$1@abraham.cs.berkeley.edu>
References: <ah7m2r$3cr$1@abraham.cs.berkeley.edu> <200207190306.g6J366956014@saturn.cs.uml.edu>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1027048984 5245 128.32.153.211 (19 Jul 2002 03:23:04 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 19 Jul 2002 03:23:04 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
>>> sys_olduname) - P
>>
>> I'd argue that this should be restricted, on general
>> principles.  (General principle: A jailed process shouldn't
>> be able to learn anything about the host it's running on.)
>
>Learning this info is easy enough without a syscall.
>You only cause trouble for legit usage.

Ok.  To be clear, I consider this minor and probably
unimportant for security, hence just allowing this is
probably reasonable.

That said, is it really true that you can learn the
hostname and the like without a syscall?  How?

>No, sys_getcwd will return info based on your current root.
>After chroot and all, your "/" is the top of your jail.

Ahh, I feel stupid for overlooking that.  You're
absolutely right.  Thanks for the correction.
