Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbWF2LK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWF2LK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWF2LK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:10:26 -0400
Received: from [82.133.102.210] ([82.133.102.210]:1690 "EHLO
	cockermouth.uk.xensource.com") by vger.kernel.org with ESMTP
	id S932729AbWF2LKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:10:25 -0400
Date: Thu, 29 Jun 2006 12:10:17 +0100
From: Emmanuel Ackaouy <ack@xensource.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Emmanuel Ackaouy <ack@xensource.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH] no_idle_hz (s390/xen) 2.6.16.13: fix next_timer_interrupt() when timer pending
Message-ID: <20060629111016.GA18989@cockermouth.uk.xensource.com>
References: <20060629101436.GA18542@cockermouth.uk.xensource.com> <1151576482.3122.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151576482.3122.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 12:21:22PM +0200, Arjan van de Ven wrote:
> Did you intend to push this patch for -stable or for the next version of
> Linux? In general if you wanted to do the later, it's a good idea to
> make a patch against the latest tree rather than a really old one....
> While if you meant the former you probably want to at least CC
> stable@vger.kernel.org .... 

Well that will teach me to be lazy... I assumed this code hadn't
moved but I see there's an equivalent fix already in place in
2.6.17.

Apologies for the noise.
