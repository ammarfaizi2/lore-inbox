Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWALOeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWALOeu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWALOeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:34:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54591 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030420AbWALOeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:34:50 -0500
Date: Thu, 12 Jan 2006 15:36:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Kedar Sovani <kedars@gmail.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sem2mutex bdev->bd_sem
Message-ID: <20060112143646.GP3945@suse.de>
References: <5edf7fc90601120610h70b824ccs9b1ac0fe955dd1b3@mail.gmail.com> <20060112141606.GO3945@suse.de> <5edf7fc90601120624q46bf0ac6h2b57a09c8ac682ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edf7fc90601120624q46bf0ac6h2b57a09c8ac682ff@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12 2006, Kedar Sovani wrote:
> Strange. It did compile in here w/o a problem.

How could it, when you don't even add bd_mutex to the block_device
structure?

I'd rather just let the patches flow from Ingo's automated setup.
Lessens the chance of problems.

-- 
Jens Axboe

