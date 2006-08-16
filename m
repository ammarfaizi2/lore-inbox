Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWHPN0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWHPN0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWHPN0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:26:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32978 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750956AbWHPN0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:26:53 -0400
Date: Wed, 16 Aug 2006 14:26:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take9 0/2] kevent: Generic event handling mechanism.
Message-ID: <20060816132631.GA32499@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <20060731103322.GA1898@2ka.mipt.ru> <11555364962921@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11555364962921@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:21:36AM +0400, Evgeniy Polyakov wrote:
> 
> Generic event handling mechanism.

Hi, I've just started looking into this, so some comments here first
on the submission process:

 - could you send new revisions of the patches in a new thread so one can
   easily find them?
 - the patch split is not very nice, your first patch adds Makefile and
   Kconfig entries for files only in the second patch or not actually
   submitted at all, that's a big no-no.

