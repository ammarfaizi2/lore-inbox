Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUJFGwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUJFGwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUJFGwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:52:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62217 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268382AbUJFGws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:52:48 -0400
Date: Wed, 6 Oct 2004 07:52:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-pcmcia@lists.infradead.org,
       fujiwara@linux-m32r.org
Subject: Re: [PATCH 2.6.9-rc3-mm2] [m32r] New CF/PCMCIA driver for m32r
Message-ID: <20041006075244.B16588@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	linux-pcmcia@lists.infradead.org, fujiwara@linux-m32r.org
References: <20041006.120502.57438367.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041006.120502.57438367.takata.hirokazu@renesas.com>; from takata@linux-m32r.org on Wed, Oct 06, 2004 at 12:05:02PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 12:05:02PM +0900, Hirokazu Takata wrote:
> This patch is for the new M32R CF/PCMCIA drivers.
> It is moved from arch/m32r/drivers/ and some part are updated 
> for 2.6 kernel.

Reading through your CF driver, I suspect you want to look at using the
soc_common.c infrastructure.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
