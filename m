Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbUBBQA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUBBQA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:00:28 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:21453 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265675AbUBBQA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:00:26 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: bttv oops
Date: 02 Feb 2004 16:47:14 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87u129eb5p.fsf@bytesex.org>
References: <401E69AD.4080606@earthlink.net>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1075736834 29333 127.0.0.1 (2 Feb 2004 15:47:14 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark <stephen.clark@earthlink.net> writes:

> Gentle people,
> 
> I am having the following problem. Also if I compile bttv into the
> kernel I get a panic in the driver at boot.
> 
> Any ideas?

disable CONFIG_I2C_*_DEBUG, the debug printk() dereference pointers
unchecked.

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
