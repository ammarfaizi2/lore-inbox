Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUFNIPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUFNIPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUFNINO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:13:14 -0400
Received: from [213.146.154.40] ([213.146.154.40]:21201 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262050AbUFNIMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:12:47 -0400
Date: Mon, 14 Jun 2004 09:12:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [5/12] Ignore errors from tw_setfeature in 3w-xxxx.c
Message-ID: <20040614081243.GD7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003835.GT1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:38:35PM -0700, William Lee Irwin III wrote:
>  * Ignore errors from tw_setfeature in drivers/scsi/3w-xxxx.c
> This fixes Debian BTS #181581.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=181581
> 
> 	From: Blars Blarson <blarson@blars.org>
> 	To: submit@bugs.debian.org
> 	Subject: kernel-source-2.4.20: 3w-xxxx driver won't configure older 3ware card
> 	Message-ID: <20030219074855.GA22346@blars.org>
> 
> The 3w-xxxx driver has changed so it will no longer configure older
> 3ware raid cards.  The attached patch allows it to work with my 3ware
> card.  (The source is the same in 2.4.20-5.)  (Note: this is an ide
> controler pretending it's scsi.)

This patch is bogus.  (And should have been sent to linux-scsi).
