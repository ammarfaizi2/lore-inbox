Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319241AbSHNQkP>; Wed, 14 Aug 2002 12:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319244AbSHNQkP>; Wed, 14 Aug 2002 12:40:15 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:25617 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319241AbSHNQkP>; Wed, 14 Aug 2002 12:40:15 -0400
Date: Wed, 14 Aug 2002 17:44:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac1
Message-ID: <20020814174407.A20146@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>; from alan@redhat.com on Wed, Aug 14, 2002 at 12:34:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 12:34:16PM -0400, Alan Cox wrote:
> o	Merge 2.4.20-pre2
> 	-	drop change to apic error logging level
> 	-	drop bogus sign cast in spin_is_locked

Could you explain your idea of brokenness a little more?

A <= 0 must happen against a explicitly signed value.

