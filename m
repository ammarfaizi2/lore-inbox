Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUFPTmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUFPTmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUFPTmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:42:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:41370 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264652AbUFPTmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:42:47 -0400
Date: Wed, 16 Jun 2004 21:42:45 +0200
From: Andi Kleen <ak@suse.de>
To: Peter Cordes <peter@cordes.ca>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
Message-Id: <20040616214245.295a1838.ak@suse.de>
In-Reply-To: <20040616192826.GD14043@cordes.ca>
References: <20040616192826.GD14043@cordes.ca>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 16:28:26 -0300
Peter Cordes <peter@cordes.ca> wrote:

> 
>  Nobody replied to this message on debian-amd64@lists.d.o, or
> discuss@x86-64.org.  Hopefully I've found the right places to send this this
> time around.  Actually, Roland Fehrenbacher saw my message in a list archive
> and mailed me to confirm that he saw the same double-speed clock problem on
> two different machines, so it's not just Tyan S2880 boards.  He suggested I
> mail Andi and lkml, so here goes.  (I haven't tested again with anything more
> recent than 2.4.27-pre2, so if this is fixed, sorry.)

It would be a good start if you could track down which kernel started
causing this behaviour (best with -bk* kernels, -pre* is not fine grained 
enough). 

-Andi
