Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVEHSTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVEHSTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVEHSTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 14:19:24 -0400
Received: from mail.nagafix.co.uk ([213.228.237.37]:29831 "EHLO
	mail.nagafix.co.uk") by vger.kernel.org with ESMTP id S262916AbVEHSTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 14:19:20 -0400
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
From: Antoine Martin <antoine@nagafix.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050508164514.GD25130@ccure.user-mode-linux.org>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	 <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra>
	 <1115483506.12131.33.camel@cobra> <m1ekchvmb0.fsf@muc.de>
	 <1115570102.10373.23.camel@cobra>
	 <20050508164514.GD25130@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Sun, 08 May 2005 20:51:26 +0100
Message-Id: <1115581886.10373.64.camel@cobra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-08 at 12:45 -0400, Jeff Dike wrote:
> On Sun, May 08, 2005 at 05:35:02PM +0100, Antoine Martin wrote:
> > The only extra patch applied on top of what is on the web page (as per
> > Jeff's instructions) is the mconsole-exec patch, and AFAIK it wouldn't
> > affect the code above.
> 
> mconsole-exec, if it's the patch I'm thinking of, is a patch to the UML
> kernel, not to the host.
Yep, that's the one, I thought the question was about the guest.
The host is running 2.6.11.8 - no extra patches at all.

> > The really weird thing is that the processes are still running, but ps
> > -ef shows an empty string in place of the process name:
> > (and the terminal which launched the instance got control back)
> > I am now rebuilding a new kernel on another test box, let me know what
> > to do to provide better debug information.
> 
> It's not unusual for UML processes to have strange names (including empty
> ones) on the host.
Strange thing is, they had names up to the point where I got the
segfault.

Antoine

