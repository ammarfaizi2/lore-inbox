Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVE0NSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVE0NSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVE0NSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:18:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:61326 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262462AbVE0NSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:18:44 -0400
X-Authenticated: #428038
Date: Fri, 27 May 2005 15:18:42 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050527131842.GC19161@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050527070353.GL1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527070353.GL1435@suse.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Jens Axboe wrote:

> Update the patch, it's against bleeding edge git (applies to 2.6.12-rc5
> as well). Changes:
> 
> - (libata) Change to SCSI change_queue_depth API, kill current hack.
> 
> - (ahci) Move SActive bit set to ahci_qc_issue() where it belongs.

OK, so this is for AHCI. What are the options for people whose
mainboards aren't blessed with AHCI, but use for instance VIA or older
Promise chips? Buy new hardware? Or wait until someone comes up with an
implementation?

Can this queueing be emulated by software (libata or the libata chipset
driver) or would such be mentioned in Jeff's list as "host-based
queueing"?

TIA,
Matthias Andree
