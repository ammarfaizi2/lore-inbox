Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbUKXSzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbUKXSzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbUKXSxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 13:53:53 -0500
Received: from [81.222.97.18] ([81.222.97.18]:9117 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S262809AbUKXSw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 13:52:59 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Christoph Hellwig <hch@infradead.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Date: Wed, 24 Nov 2004 21:47:45 +0300
User-Agent: KMail/1.7
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296414.5805.286.camel@desktop.cunninghams> <20041124132949.GB13145@infradead.org>
In-Reply-To: <20041124132949.GB13145@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411242147.45766.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph, 
On 24 November 2004 16:29, Christoph Hellwig wrote:
> On Wed, Nov 24, 2004 at 11:59:02PM +1100, Nigel Cunningham wrote:
> > Here we add simple hooks so that the user can interact with suspend
> > while it is running. (Hmm. The serial console condition could be
> > simplified :>). The hooks allow you to do such things as:
> >
> > - cancel suspending
> > - change the amount of detail of debugging info shown
> > - change what debugging info is shown
> > - pause the process
> > - single step
> > - toggle rebooting instead of powering down
>
> And why would we want this?  If the users calls the suspend call
> he surely wants to suspend, right?
Probably, wrong. Suspend running server remotely, to resolve hotswap issues, 
f.e., and reboot to already prepared environment, without bothering 
techsupport in the middle of the night. 
>
> After all we don't have inkernel hooks to allow a user to read instead
> write after calling sys_write.
Wrong analogy here, sorry.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Managing your Territory since the dawn of times ...
