Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319048AbSIDEnZ>; Wed, 4 Sep 2002 00:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319049AbSIDEnZ>; Wed, 4 Sep 2002 00:43:25 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:27386 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319048AbSIDEnY>; Wed, 4 Sep 2002 00:43:24 -0400
Date: Wed, 4 Sep 2002 00:47:57 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Joseph N. Hall" <joseph@5sigma.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help diagnosing poorly performance of IDE DVD-RAM/R/ROM
Message-ID: <20020904004757.A357@redhat.com>
References: <20020904014354Z319000-685+42498@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020904014354Z319000-685+42498@vger.kernel.org>; from joseph@5sigma.com on Tue, Sep 03, 2002 at 06:50:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 06:50:00PM -0700, Joseph N. Hall wrote:
> (Argh. My apologies for the garbled subject first time round.)
> 
> Dear Kernel Folks,
> 
> I am trying to determine the cause of the poor performance of a
> an IDE DVD device on my new machine.  I have an IDE Panasonic DF-210-type

Enable DMA.  Note that the initscripts in Red Hat 7.3 disable DMA on 
all non-harddrive devices.

		-ben
