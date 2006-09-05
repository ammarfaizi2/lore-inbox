Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWIENkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWIENkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWIENkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:40:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:29870 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965036AbWIENkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:40:02 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take15 4/4] kevent: Timer notifications.
Date: Tue, 5 Sep 2006 15:39:57 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
References: <11573648632380@2ka.mipt.ru>
In-Reply-To: <11573648632380@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051539.58492.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 12:14, Evgeniy Polyakov wrote:
> Timer notifications can be used for fine grained per-process time 
> management, since interval timers are very inconvenient to use, 
> and they are limited.

I guess this must have been discussed before, but why is this
not using high-resolution timers?

Are you planning to change this?

Maybe at least mention it in the description.

	Arnd <><
