Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbVJ0WMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbVJ0WMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVJ0WMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:12:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:60577 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932673AbVJ0WMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:12:06 -0400
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org
Subject: Re: 4GB memory and Intel Dual-Core system
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2005 00:12:04 +0200
In-Reply-To: <52mzkuwuzg.fsf@cisco.com>
Message-ID: <p73wtjy38zv.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> writes:
> 
> I don't know if EM64T systems (or whatever the right term is) have a
> way of remapping some RAM above 4 GB so that you can use all your
> memory in a case like this.

The lower/middle end non server intel chipsets typically only support
4GB of physical address space in hardware. No memory remapping
possible. So with 4GB RAM you always lose to the memory hole.

-Andi
