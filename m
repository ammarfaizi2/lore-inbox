Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbUKJGVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUKJGVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 01:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUKJGVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 01:21:36 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:5509 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261902AbUKJGVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 01:21:00 -0500
Date: Wed, 10 Nov 2004 07:20:59 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Con Kolivas <kernel@kolivas.org>
Cc: Patrick Mau <mau@oscar.ping.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Workaround for wrapping loadaverage
Message-ID: <20041110062059.GA20467@mail.13thfloor.at>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	Patrick Mau <mau@oscar.ping.de>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041108001932.GA16641@oscar.prima.de> <20041108012707.1e141772.akpm@osdl.org> <20041108102553.GA31980@oscar.prima.de> <20041108155051.53c11fff.akpm@osdl.org> <20041109004335.GA1822@oscar.prima.de> <20041109185103.GE29661@mail.13thfloor.at> <41913B75.1050500@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41913B75.1050500@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 08:49:41AM +1100, Con Kolivas wrote:
> Herbert Poetzl wrote:
> >but I agree that a higher resolution would be a good
> >idea ... also doing the calculation when the number
> >of running/uninterruptible processes has changed would
> >be a good idea ...
> 
> This could get very expensive. A modern cpu can do about 700,000 context 
> switches per second of a real task with the current linux kernel so I'd 
> suggest not doing this.

hmm, right it can, do you have any stats about the
'typical' workload behaviour? 

do you know the average time between changes of 
nr_running and nr_uninterruptible?

TIA,
Herbert

> Cheers,
> Con


