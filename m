Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTDXAnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbTDXAnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:43:47 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:12807 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S264352AbTDXAnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:43:46 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: kernel ring buffer accessible by users
Date: 24 Apr 2003 00:30:17 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b87b6p$sks$2@abraham.cs.berkeley.edu>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <20030423125602.B1425@almesberger.net> <1051113589.707.948.camel@localhost> <20030423132359.B3557@almesberger.net>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1051144217 29340 128.32.153.211 (24 Apr 2003 00:30:17 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 24 Apr 2003 00:30:17 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger  wrote:
>Robert Love wrote:
>> Why on earth would the user give the kernel a password?
>
>That's just an example. It could be any other sensitive information,
>including kernel state that you don't want to reveal to users.
>
>I think it's a reasonable assumption that one can speak freely in a
>printk message.

Robert Love's position seems reasonable to me.  Can you show an example
where it is useful and appropriate to print secrets out using printk()?
It strikes me as risky and unnecessary, but maybe I'm missing something.
