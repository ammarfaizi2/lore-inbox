Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268492AbUHLJRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268492AbUHLJRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268489AbUHLJRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:17:21 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17423 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268483AbUHLJRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:17:10 -0400
Date: Thu, 12 Aug 2004 10:17:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: Altix I/O code reorganization - 6 of 21
Message-ID: <20040812101708.D5988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408112327.i7BNRb5w163586@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408112327.i7BNRb5w163586@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Aug 11, 2004 at 06:27:37PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:27:37PM -0500, Pat Gefre wrote:
> 2 additional SAL calls were added.  This SAL call multiplexes 
> into 10 different calls inside of Prom:

Which makes it less non-standard?

> Eventhough, we live within the arch/ia64, our IO Chipsets are definitely not 
> anything close to every other arch/ia64 platforms.

Please look a little closer at the HP zx1 :)

> What PPB code in the Linux kernel are you commenting on?

Spread drivers/pci/*.  Didn't it ever happen to you that Pci to PCI bridges
just work on any other linux plattform?

