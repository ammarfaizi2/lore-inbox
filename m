Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUAWVeC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 16:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266706AbUAWVeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 16:34:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4069 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266705AbUAWVd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 16:33:59 -0500
Date: Fri, 23 Jan 2004 16:33:29 -0500
From: Alan Cox <alan@redhat.com>
To: Glenn Wurster <gwurster@scs.carleton.ca>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, alan@redhat.com,
       andre@linux-ide.org
Subject: Re: [PATCH] ide-dma.c, ide.c, ide.h, kernel 2.4.24
Message-ID: <20040123213329.GH22615@devserv.devel.redhat.com>
References: <20040123183245.GB853@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123183245.GB853@desktop>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 01:32:45PM -0500, Glenn Wurster wrote:
> 
> Brief Synopsis:
> 
> IDE initialization on non-DMA controllers causes OOPS during boot
> due to dereference of null function pointers.

Linus - I am ok with this but for 2.6 Bart needs to look at it I guess
