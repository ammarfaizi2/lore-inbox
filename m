Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265273AbSIWJ4Z>; Mon, 23 Sep 2002 05:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSIWJ4Z>; Mon, 23 Sep 2002 05:56:25 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:58855 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265273AbSIWJ4Y>;
	Mon, 23 Sep 2002 05:56:24 -0400
Date: Mon, 23 Sep 2002 12:01:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 oopses at boot in ide_toggle_bounce
Message-ID: <20020923100134.GA16260@win.tue.nl>
References: <UTC200209211211.g8LCBcW16848.aeb@smtp.cwi.nl> <20020923074142.GB15479@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923074142.GB15479@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 09:41:42AM +0200, Jens Axboe wrote:

> Patch is fine, thanks Andries.

Yes, that patch allows the kernel to boot.
The booted system has two main problems that 2.5.33 does not have:
(i) It no longer sees my disks on an HPT366,
(ii) pgrp handling changed, so that some programs hang.

Andries
