Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269342AbUIIIDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269342AbUIIIDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269365AbUIIIDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:03:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6929 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269342AbUIIIDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:03:18 -0400
Date: Thu, 9 Sep 2004 09:03:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [patch][9/9] block: remove bio walking
Message-ID: <20040909090314.A24950@flint.arm.linux.org.uk>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409082127.04331.bzolnier@elka.pw.edu.pl>; from bzolnier@elka.pw.edu.pl on Wed, Sep 08, 2004 at 09:27:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> [patch] block: remove bio walking
> 
> IDE driver was the only user of bio walking code.

The MMC driver also uses this.  Please don't remove.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
