Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbUKXOJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbUKXOJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbUKXOH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:07:26 -0500
Received: from zeus.kernel.org ([204.152.189.113]:35277 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262680AbUKXNkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:40:13 -0500
Date: Wed, 24 Nov 2004 13:29:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Message-ID: <20041124132949.GB13145@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296414.5805.286.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101296414.5805.286.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 11:59:02PM +1100, Nigel Cunningham wrote:
> Here we add simple hooks so that the user can interact with suspend
> while it is running. (Hmm. The serial console condition could be
> simplified :>). The hooks allow you to do such things as:
> 
> - cancel suspending
> - change the amount of detail of debugging info shown
> - change what debugging info is shown
> - pause the process
> - single step
> - toggle rebooting instead of powering down

And why would we want this?  If the users calls the suspend call
he surely wants to suspend, right?

After all we don't have inkernel hooks to allow a user to read instead
write after calling sys_write.
