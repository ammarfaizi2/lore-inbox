Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271276AbTGWUPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271299AbTGWUPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:15:15 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:53767 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271275AbTGWUMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:12:51 -0400
Date: Wed, 23 Jul 2003 21:27:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030723212755.A608@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, uclinux-dev@uclinux.org,
	linux-kernel@vger.kernel.org
References: <200307232046.46990.bernie@develer.com> <20030723193246.GA836@lst.de> <20030723131154.472172d0.davem@redhat.com> <20030723211533.A434@infradead.org> <20030723132256.58ee50e7.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030723132256.58ee50e7.davem@redhat.com>; from davem@redhat.com on Wed, Jul 23, 2003 at 01:22:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 01:22:56PM -0700, David S. Miller wrote:
> Drivers weren't audited much, and there's a lot of boneheaded
> stuff in this area.  But these should be mostly identical
> to what would happen on the 2.4.x side

Please read the original message again - he stated that every single
module in fs/ got alot bigger - if it gets smaller or at least the
same size as 2.4 it's clearly a sign of inlines gone mad in the
filesystem/VM code and we need to look at that.  If not we have to look
elsewhere.

