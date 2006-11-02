Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWKBGeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWKBGeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 01:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbWKBGeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 01:34:19 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36803 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750943AbWKBGeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 01:34:18 -0500
Date: Thu, 2 Nov 2006 09:21:58 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nate Diller <nate.diller@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>,
       Pavel Machek <pavel@ucw.cz>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061102062158.GC5552@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru> <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 02 Nov 2006 09:29:36 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 06:12:41PM -0800, Nate Diller (nate.diller@gmail.com) wrote:
> Indesiciveness has certainly been an issue here, but I remember akpm
> and Ulrich both giving concrete suggestions.  I was particularly
> interested in Andrew's request to explain and justify the differences
> between kevent and BSD's kqueue interface.  Was there a discussion
> that I missed?  I am very interested to see your work on this
> mechanism merged, because you've clearly emphasized performance and
> shown impressive results.  But it seems like we lose out on a lot by
> throwing out all the applications that already use kqueue.

It looks you missed that discussion - freebsd kqueue has fields in the 
kevent structure which have diffent sizes in 32 and 64 bit environments.

> NATE

-- 
	Evgeniy Polyakov
