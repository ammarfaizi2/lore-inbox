Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSIBVxf>; Mon, 2 Sep 2002 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318518AbSIBVxe>; Mon, 2 Sep 2002 17:53:34 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:48393 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S318497AbSIBVxe>;
	Mon, 2 Sep 2002 17:53:34 -0400
Date: Mon, 2 Sep 2002 23:58:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Andries.Brouwer@cwi.nl, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
       <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Message-ID: <20020902215803.GA9359@win.tue.nl>
References: <UTC200209022127.g82LR3g12738.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0209021542590.3270-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209021542590.3270-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 03:43:56PM -0600, Thunder from the hill wrote:

> > The faraway goal is: no partition table reading in the kernel.
> 
> Why not the faraway goal: no partition tables any more? They're annoying.

As soon as the kernel stops reading partition tables, user space
is entirely free in what it does. One of the possibilities is
then of course: no partition tables.
