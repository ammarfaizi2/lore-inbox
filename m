Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUJTPqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUJTPqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268421AbUJTPpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:45:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46808 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268166AbUJTPgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:36:04 -0400
Date: Wed, 20 Oct 2004 17:35:11 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Timothy Miller <miller@techsource.com>
Cc: Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20041020153510.GA21556@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <417687BE.5020900@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417687BE.5020900@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Given the finite and small number of IRQ stacks required, I see no 
> reason not to make them 8K, other than for elegance sake.  You're not 
> really wasting much memory by giving IRQ's 8k stacks.

really sucky though; look at how current is implemented.
