Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTLBLnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 06:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTLBLnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 06:43:49 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:52489 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261898AbTLBLns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 06:43:48 -0500
Date: Tue, 2 Dec 2003 12:43:50 +0100
To: Johannes Stezenbach <js@convergence.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 ioctl compile warnings in userspace
Message-ID: <20031202114350.GA25170@iliana>
References: <20031112163750.GB18989@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031112163750.GB18989@convergence.de>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 05:37:50PM +0100, Johannes Stezenbach wrote:
> Hi,
> 
> the patch below fixes
> 
>   warning: signed and unsigned type in conditional expression
> 
> when compiling userspace programs with a glibc built against
> 2.6 kernel headers.
> 
> This is a better version of my previous patch which aims
> to fix all affected architectures.

I am curious about this. 

This patch has been proposed since almost a month or more now, and
clearly nobody seems to care about this, since it didn't make it in the
2.6.0-test11 tarball (don't know about more recent bk trees though) nor
do the debian glibc maintainer judge the issue important enough to act
on it (despite it breaking buildage of other packages).

So, is there a reason why not to solve this problem this way, or a
particular reason why __invalid_size_argument_for_IOC is still int and
not unsigned int ?

Friendly,

Sven Luther
