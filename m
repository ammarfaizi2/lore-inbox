Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUHGRLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUHGRLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUHGRLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:11:25 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:62476 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263626AbUHGRLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:11:23 -0400
Date: Sat, 7 Aug 2004 18:10:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040807181051.A19250@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, wli@holomorphy.com, davem@redhat.com,
	geert@linux-m68k.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
	sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
References: <20040807170122.GM17708@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040807170122.GM17708@fs.tum.de>; from bunk@fs.tum.de on Sat, Aug 07, 2004 at 07:01:22PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 07:01:22PM +0200, Adrian Bunk wrote:
> The following architetures have their own "config PCMCIA" instead of 
> including drivers/pcmcia/Kconfig (in 2.6.8-rc3-mm1):
> - m68k
> - s390
> - sparc
> - sparc64
> 
> Is there any good reason for this, or would a patch to change these 
> architectures to include drivers/pcmcia/Kconfig be OK?

What about switching them to use drivers/Kconfig instead?

