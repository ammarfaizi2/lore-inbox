Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261899AbSJIULL>; Wed, 9 Oct 2002 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbSJIULL>; Wed, 9 Oct 2002 16:11:11 -0400
Received: from blueberrysolutions.com ([195.165.170.195]:11413 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id <S261899AbSJIULK>; Wed, 9 Oct 2002 16:11:10 -0400
Date: Wed, 9 Oct 2002 23:16:44 +0300 (EEST)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: teg@blueberrysolutions.com
To: Chris Wright <chris@wirex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: capable()-function
In-Reply-To: <20021009121615.B25392@figure1.int.wirex.com>
Message-ID: <Pine.LNX.4.44.0210092314260.785-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Chris Wright wrote:

> You could dump something like this before the capable() call:
> 
> printk(KERN_DEBUG "%s:(%d) eff: 0x%x\n", current->comm, current->pid,
> 						cap_t(current->cap_effective));

Ok. I got following result:

ÿÿ:(12290) eff: 0x0

Is the eff-value current capabilities? Why it is zero? The task who called 
it (cardmgr) was owned by root.

-- 
* Tony Glader 

