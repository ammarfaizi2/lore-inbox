Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269555AbTHJOwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269559AbTHJOwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:52:04 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15108 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269555AbTHJOwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:52:03 -0400
Date: Sun, 10 Aug 2003 15:51:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
Message-ID: <20030810155159.A18400@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, yoshfuji@linux-ipv6.org,
	linux-kernel@vger.kernel.org
References: <20030810013041.679ddc4c.davem@redhat.com> <20030810090556.GY31810@waste.org> <20030810020444.48cb740b.davem@redhat.com> <20030810.201009.77128484.yoshfuji@linux-ipv6.org> <20030810123148.A10435@infradead.org> <20030810045121.31ef7ccc.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810045121.31ef7ccc.davem@redhat.com>; from davem@redhat.com on Sun, Aug 10, 2003 at 04:51:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 04:51:21AM -0700, David S. Miller wrote:
> On Sun, 10 Aug 2003 12:31:48 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > You probably want to use pci_map_single here instead..
> 
> I don't think it's wise to mix two changes at once.  Let's get
> the straightforward "obvious" shorthand change in, then we can
> add your enhancement.

Ok.

