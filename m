Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVFFQCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVFFQCC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVFFQCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:02:01 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:38081 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261225AbVFFQBq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:01:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IIs56KADn2DmuEnlCsYYrFGZ05ViIABTOKqx45o4OvgR/CpAtpxorDjEgeVh2BrBHGU2F/dXWVgOdbvBtpgEiwHbj66bC0OlI0wYYzCMFyWVYsOrhRUOY96k8tlBfsHq4Xbumz4HiuEs2C5V2pUDbRIOwJWbHyv4th1pqEY2oaQ=
Message-ID: <58cb370e05060609014039a23@mail.gmail.com>
Date: Mon, 6 Jun 2005 18:01:14 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Broken nForce2 IDE module loading via hotplug
Cc: Andrew Chew <AChew@nvidia.com>, Juerg Billeter <juerg@paldo.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42947ED9.9040401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <DBFABB80F7FD3143A911F9E6CFD477B00604C7BE@hqemmail02.nvidia.com>
	 <42947ED9.9040401@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Andrew Chew wrote:
> > Actually, it occurred to me that it would be better if the determination
> > to use the generic entry can be run-time specified (via a kernel option
> > flag, for example).  All the kernel config option accomplishes is a
> > cleaner way to disable the generic entry at compile time.
> >
> > In any case, it'd be interesting to figure out the EXACT root of the
> > problem.  Let me spend a few days looking into it.
> 
> Any progress?

It would be nice to get it fixed before 2.6.12...
Even if it means reverting the patch...

Bartlomiej
