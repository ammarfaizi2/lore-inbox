Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbUKAMET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUKAMET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbUKAMET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:04:19 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:8966 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261759AbUKAMEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:04:16 -0500
Date: Mon, 1 Nov 2004 12:04:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Disambiguation for panic_timeout's sysctl
Message-ID: <20041101120411.GA26958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olaf Hering <olh@suse.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0410311721470.20529@yvahk01.tjqt.qr> <20041101120227.GA24626@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101120227.GA24626@suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 01:02:27PM +0100, Olaf Hering wrote:
>  On Sun, Oct 31, Jan Engelhardt wrote:
> 
> > 
> > 
> > The /proc/sys/kernel/panic file looked to me like it was something like
> > /proc/sysrq-trigger -- until I looked into the kernel sources which reveal that
> > it sets the variable "panic_timeout" in kernel/sched.c.
> 
> This will probably break applications that expect the filename 'panic'.

And why should applications care for the panic timeout?  Especially only
a few days after it's been added to the kernel?

