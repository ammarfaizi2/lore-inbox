Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUEPV27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUEPV27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEPV27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:28:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28900 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263028AbUEPV25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:28:57 -0400
Message-ID: <40A7DD0C.7010007@pobox.com>
Date: Sun, 16 May 2004 17:28:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [patch] kill off PC9800
References: <1084729840.10938.13.camel@mulgrave> <20040516142123.2fd8611b.akpm@osdl.org>
In-Reply-To: <20040516142123.2fd8611b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Well it's a question of whether we're likely to see increasing demand for
> [pc9800] in the future.  If so then it would be prudent to put some effort into
> fixing it up rather than removing it.
> 
> Seems that's not the case.  I don't see a huge rush on this but if after
> this discussion nobody steps up to take care of the code over the next few
> weeks, it's best to remove it.


Although I like deleting things as much as the next guy :) I do have a 
question, to which I haven't come up with a good answer myself:

Should PC9800 be excised en masse, or just toss the obviously broken or 
not-in-any-makefile/Kconfig pieces?

The PC9800 net driver stuff still seems to build, and be sane.

	Jeff



