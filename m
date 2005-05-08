Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVEHRfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVEHRfb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 13:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVEHRfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 13:35:30 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:5128 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262906AbVEHRfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 13:35:21 -0400
Date: Sun, 8 May 2005 12:45:14 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050508164514.GD25130@ccure.user-mode-linux.org>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <m1ekchvmb0.fsf@muc.de> <1115570102.10373.23.camel@cobra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115570102.10373.23.camel@cobra>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 05:35:02PM +0100, Antoine Martin wrote:
> The only extra patch applied on top of what is on the web page (as per
> Jeff's instructions) is the mconsole-exec patch, and AFAIK it wouldn't
> affect the code above.

mconsole-exec, if it's the patch I'm thinking of, is a patch to the UML
kernel, not to the host.

> The really weird thing is that the processes are still running, but ps
> -ef shows an empty string in place of the process name:
> (and the terminal which launched the instance got control back)
> I am now rebuilding a new kernel on another test box, let me know what
> to do to provide better debug information.

It's not unusual for UML processes to have strange names (including empty
ones) on the host.

				Jeff
