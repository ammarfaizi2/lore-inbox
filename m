Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVHDNtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVHDNtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVHDNrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:47:20 -0400
Received: from [85.8.12.41] ([85.8.12.41]:28811 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262531AbVHDNpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:45:34 -0400
Message-ID: <42F21BD6.3000807@drzeus.cx>
Date: Thu, 04 Aug 2005 15:44:54 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-0.1.fc5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 8139cp misses interrupts during resume
References: <42DD3BA1.7010302@drzeus.cx>
In-Reply-To: <42DD3BA1.7010302@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> I'm having problem with the interrupt getting killed after suspend with
> my 8139cp controller. The problem only appears if the cable is connected
> during resume (before suspend is irrelevant) and the interface is down.
> 
> Both suspend-to-disk and suspend-to-ram exhibit the error. dmesg from
> suspend-to-ram included.
> 
> I find it a bit strange that 8139cp's interrupt handler isn't included
> when it dumps the handlers. Could this be related to the problem?
> 

Anyone familiar with this driver that can give me some pointers on what
to look for? I'd prefer not to have to learn how the entire thing works
just to fix one bug. :)

Rgds
Pierre
