Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTDXAoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTDXAoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:44:55 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:13575 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S264362AbTDXAow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:44:52 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: kernel ring buffer accessible by users
Date: 24 Apr 2003 00:31:22 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b87b8q$sks$3@abraham.cs.berkeley.edu>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <1051031876.707.804.camel@localhost> <20030423125602.B1425@almesberger.net> <20030423160556.GA30306@frodo.midearth.frodoid.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1051144282 29340 128.32.153.211 (24 Apr 2003 00:31:22 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 24 Apr 2003 00:31:22 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster wrote:
>Of course one could say "then let's just stop writing out anything in
>the kernel buffer that COULD be sensitive", but I think this would
>actually castrate the meaning of such a buffer.

Would it?  I can't think of anything that currently should be printed
to the ring buffer and is known to be secret.
