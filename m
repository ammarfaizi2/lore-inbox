Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUEQXZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUEQXZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUEQXZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:25:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45586 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263147AbUEQXZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:25:34 -0400
Date: Tue, 18 May 2004 00:25:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Robert.Picco@hp.com,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-ID: <20040518002528.B26439@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, Robert.Picco@hp.com,
	linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com> <40A93DA5.4020701@hp.com> <20040517160508.63e1ddf0.akpm@osdl.org> <20040517161212.659746db.akpm@osdl.org> <40A94857.9030507@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40A94857.9030507@pobox.com>; from jgarzik@pobox.com on Mon, May 17, 2004 at 07:18:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 07:18:47PM -0400, Jeff Garzik wrote:
> Seems sane, though I wonder about two things:
> 
> * better home is probably asm-generic

hmm, I wonder about endian issues tho (and please remember that ARM can
be either BE or LE depending on the machine we're building for...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
