Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTLQRfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTLQRfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:35:44 -0500
Received: from needs-no.brain.uni-freiburg.de ([132.230.63.23]:10009 "EHLO
	needs-no.brain.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264480AbTLQRfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:35:43 -0500
Date: Wed, 17 Dec 2003 18:35:37 +0100 (MET)
From: Thomas Voegtle <thomas@voegtle-clan.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
In-Reply-To: <20031217164832.GA2495@suse.de>
Message-ID: <Pine.LNX.4.21.0312171832120.32429-100000@needs-no.brain.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Jens Axboe wrote:

> 
> Apply this to test11-bkLATEST
> 
> ===== drivers/block/scsi_ioctl.c 1.38 vs edited =====
> --- 1.38/drivers/block/scsi_ioctl.c	Thu Dec 11 18:55:17 2003

Yes, this fixes the problem.
I have now 2.6.0-test11-bk13 + patch.

Thank you,

Thomas

-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------


