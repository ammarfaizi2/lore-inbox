Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUFNIND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUFNIND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUFNIMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:12:40 -0400
Received: from [213.146.154.40] ([213.146.154.40]:19153 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262050AbUFNIL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:11:56 -0400
Date: Mon, 14 Jun 2004 09:11:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [3/12] remove irda usage of isa_virt_to_bus()
Message-ID: <20040614081155.GC7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003605.GR1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:36:05PM -0700, William Lee Irwin III wrote:
>  * Removed uses of isa_virt_to_bus
> This resolves Debian BTS #218878.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=218878
> 
> 	From: Paavo Hartikainen <pahartik@sci.fi>
> 	To: Debian Bug Tracking System <submit@bugs.debian.org>
> 	Subject: IrDA modules fail to load
> 	Message-Id: <E1AGYn5-0000LT-00@mufasa.vip.fi>
> 
> When trying to "modprobe irda irtty", it fails with following message:
>   FATAL: Error inserting irda (/lib/modules/2.6.0-test9/kernel/net/irda/irda.ko): Unknown symbol in module, or unknown parameter (see dmesg)
> And in "dmesg" I see these:
>   irda: Unknown symbol isa_virt_to_bus
>   irda: Unknown symbol isa_virt_to_bus

netdev would be the right list I guess. 

