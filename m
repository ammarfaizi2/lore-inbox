Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRLLOph>; Wed, 12 Dec 2001 09:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280448AbRLLOp2>; Wed, 12 Dec 2001 09:45:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29710 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280410AbRLLOpU>; Wed, 12 Dec 2001 09:45:20 -0500
Date: Wed, 12 Dec 2001 15:45:15 +0100
From: Jan Kara <jack@suse.cz>
To: Simon Byrnand <simon@igrin.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in disk Quota's on 2.2.19 (and maybe other kernels) ?
Message-ID: <20011212154515.C16674@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3.0.6.32.20011211164149.00b7ba20@mail.igrin.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.6.32.20011211164149.00b7ba20@mail.igrin.co.nz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I've just started using Disk Quotas with Redhat 6.2, and 2.2.19 kernel, ext2.
> 
> Everything is working ok except I notice an anomoly - if I have an apache
> log file (which is kept open while apache is running) which is owned by a
> normal user account, and I chown it to root, the quotas are not updated to
> reflect the fact that the user who used to own the file should have less
> space "used" from their quota. There should be a decrease in the amount of
> space used in their quota by the size of the file.
  I tried to reproduce the problem at home but I didn't succeed. Are you
able to reproduce the problem? Is the problem occuring just for that
log file or chowning any file doesn't work?

								Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
