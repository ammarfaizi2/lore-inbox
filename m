Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271144AbTGWGrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271145AbTGWGrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:47:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15632 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271125AbTGWGrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:47:17 -0400
Date: Wed, 23 Jul 2003 08:02:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: solca@guug.org, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723080222.A5245@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, solca@guug.org,
	zaitcev@redhat.com, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com> <20030723070739.A697@infradead.org> <20030722232410.7a37ed4d.davem@redhat.com> <20030723072836.A932@infradead.org> <20030722232911.2e6fda86.davem@redhat.com> <20030723074033.A1687@infradead.org> <20030722235714.5e2b285d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030722235714.5e2b285d.davem@redhat.com>; from davem@redhat.com on Tue, Jul 22, 2003 at 11:57:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:57:14PM -0700, David S. Miller wrote:
> I don't see why this is a problem.  Either do this, or fix
> asm-generic/dma-mapping.h which is not GENERIC because it
> depends upon something SPECIFIC, specifically PCI.

The latter is what need to be done.  

