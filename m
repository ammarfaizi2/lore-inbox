Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVABBFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVABBFV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 20:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVABBFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 20:05:20 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:28174 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261212AbVABBEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 20:04:43 -0500
Date: Sun, 2 Jan 2005 02:04:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Fryderyk Mazurek <dedyk@go2.pl>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       gustavo@compunauta.com
Subject: Re: [ide] ide-disk: enable stroke by default - was Re: Problems with 2.6.10
Message-ID: <20050102010434.GE2818@pclin040.win.tue.nl>
References: <fa.b02ekp9.12i8ti1@ifi.uio.no> <fa.ekat19o.emk580@ifi.uio.no> <E1CktTx-0003bC-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CktTx-0003bC-00@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fryderyk Mazurek wrote:
> 
> > At last I fixed my problem! I changed source to not enable "Host
> > Protected Area". This means that on 2.6.10 I have 33,8GB disk, not
> > 40GB, how on "true" 2.6.10. And now my BIOS detect my disk. But
> > question is, what does "true" kernel do, and why influence to BIOS?
> > Maybe this is kernel BUG?

Yes, I see the changeset

   <bzolnier@trik.(none)> (04/10/29 1.2341)
   [ide] ide-disk: enable stroke by default
   From: Jens Axboe <axboe@suse.de>

that enables stroke by default. That is good.
What I don't see is the option not to enable it.
That is, we used to have "stroke", but we want to have "nostroke".

Andries
