Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUFCR3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUFCR3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbUFCR2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:28:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40460 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265603AbUFCRVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:21:33 -0400
Date: Thu, 3 Jun 2004 18:21:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Export swapper_space
Message-ID: <20040603182127.F8244@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040603161909.D8244@flint.arm.linux.org.uk> <20040603153727.GA17798@infradead.org> <20040603170137.E8244@flint.arm.linux.org.uk> <20040603100826.2fd235c8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040603100826.2fd235c8.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 03, 2004 at 10:08:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 10:08:26AM -0700, Andrew Morton wrote:
> Christoph means "can arm uninline flush_dcache_page()"?
> 
> It looks like that would be the best approach - it's quite a large function.

Grumble.  We could, though I didn't expect it to become a large
function...  I guess the bloat monster has been fed again. ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
