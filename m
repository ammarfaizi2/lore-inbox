Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTENR2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTENR2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:28:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9876 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263250AbTENR2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:28:14 -0400
Date: Wed, 14 May 2003 19:40:50 +0200
From: Jens Axboe <axboe@suse.de>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
Cc: "'Rafal Bujnowski'" <bujnor@go2.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
Message-ID: <20030514174050.GQ15261@suse.de>
References: <785F348679A4D5119A0C009027DE33C102E0D35F@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D35F@mcoexc04.mlm.maxtor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Mudama, Eric wrote:
> 0x5104 is a different can of worms from the other stuff you guys were
> reporting.
> 
> 5104 (status register = 0x51, error register 0x04) is the all-encompassing
> "command abort" which is what the drive does any time you issue a command
> with bad parameters, an invalid (immoral?) command, or some of the security
> stuff out of sequence.  Most commonly it is seen attempting to enable
> features on a drive that doesn't support them.

Which reminds me that it has always annoyed me that Linux doesn't print
the failed command. Just leaves a lot of guess work... I'll try and
remedy that.

-- 
Jens Axboe

