Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUHYPPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUHYPPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHYPPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:15:10 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:51977 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267690AbUHYPPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:15:06 -0400
Date: Wed, 25 Aug 2004 16:15:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] TIOCCONS security
Message-ID: <20040825161504.A8896@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040825151106.GA21687@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040825151106.GA21687@suse.de>; from od@suse.de on Wed, Aug 25, 2004 at 05:11:06PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 05:11:06PM +0200, Olaf Dabrunz wrote:
> Hi,
> 
> the ioctl TIOCCONS allows any user to redirect console output to another
> tty. This allows anyone to suppress messages to the console at will.
> 
> AFAIK nowadays not many programs write to /dev/console, except for start
> scripts and the kernel (printk() above console log level).
> 
> Still, I believe that administrators and operators would not like any
> user to be able to hijack messages that were written to the console.
> 
> The only user of TIOCCONS that I am aware of is bootlogd/blogd, which
> runs as root. Please comment if there are other users.

Oh, common.  Do your basic research - this has been rejected a few times
and there have been better proposals.  Just use goggle a little bit.

