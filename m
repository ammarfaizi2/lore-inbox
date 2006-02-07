Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWBGNrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWBGNrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWBGNrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:47:43 -0500
Received: from mail.tmr.com ([64.65.253.246]:28166 "EHLO firewall2.tmr.com")
	by vger.kernel.org with ESMTP id S965083AbWBGNrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:47:41 -0500
Date: Tue, 7 Feb 2006 08:47:34 -0500 (EST)
From: Bill Davidsen <tmrbill@tmr.com>
Reply-To: davidsen@tmr.com
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Matt Keenan <matt.keenan@btinternet.com>, Jens Axboe <axboe@suse.de>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
In-Reply-To: <1139310269.8347.93.camel@capoeira>
Message-ID: <Pine.LNX.4.44.0602070836360.22104-100000@firewall2.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Xavier Bestel wrote:

> On Tue, 2006-02-07 at 10:22, Matt Keenan wrote:
> > Is there a document that clearly lists how these components (SCSI, 
> > SG_IO, ATA/PI etc et al) connect together and what protocol / transports 
> > they use? I suspect the problem with all these current arguments is that 
> > very few people understand how this all works / connects.
> 
> Maybe people that don't understand how all these components are tied
> together should refrain from arguing about them ?

Don't mislead yourself into thinking that "don't understand why anyone 
would do it this way" implies "don't understand how it works."

This is mostly a discussion of keeping the kernel simple and letting the 
applications cope with the constantly changing interfaces vs. keeping the 
application interface constant (or at least not breaking things which did 
work) and having the kernel more complex.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
Doing interesting things with little computers since 1979

