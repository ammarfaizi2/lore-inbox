Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275001AbTHRQ5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHRQ5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:57:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29313 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S274813AbTHRQ4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:56:44 -0400
Date: Mon, 18 Aug 2003 09:49:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030818094955.3aa5c1c2.davem@redhat.com>
In-Reply-To: <m365kvufjx.fsf@defiant.pm.waw.pl>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
	<m3r83jyw2k.fsf@defiant.pm.waw.pl>
	<20030818054341.2ef07799.davem@redhat.com>
	<m365kvufjx.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2003 17:54:42 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> "David S. Miller" <davem@redhat.com> writes:
> 
> > Because the other platforms don't to do anything special wrt. this
> > they can just ignore consitent_dma_mask altogether.
> 
> No. The documentation states that consistent_dma_mask (and not dma_mask)
> will be used when doing pci_alloc_consistent().

Then the platforms need to implement the code.
