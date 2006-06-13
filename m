Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWFMVaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWFMVaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFMVai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:30:38 -0400
Received: from hera.kernel.org ([140.211.167.34]:29111 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932243AbWFMVai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:30:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: more than 3 GB in userspace (4G/4G patch?) for 2.6.16
Date: Tue, 13 Jun 2006 14:30:27 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6napj$3j0$1@terminus.zytor.com>
References: <448F207A.6080601@hanno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150234227 3681 127.0.0.1 (13 Jun 2006 21:30:27 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 13 Jun 2006 21:30:27 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <448F207A.6080601@hanno.de>
By author:    Hanno Mueller <sockpuppet@hanno.de>
In newsgroup: linux.dev.kernel
> 
> on my 8 GB system with two 32-bit-xeons, I would like to have more than
> 3 gigs in userspace.
> 

See if you can replace them with 64-bit Xeons.  That would be the best option.

> A 0.5/3.5 GB split appears to be what I need for my application.

That is incompatible with PAE.  The way PAE works, the split has to be
an even number of gigabytes.

	-hpa
