Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266125AbUFRQ2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266125AbUFRQ2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUFRQ2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:28:22 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:9477 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266125AbUFRQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:28:18 -0400
Subject: Re: 2.6.7-ck1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200406162122.51430.kernel@kolivas.org>
References: <200406162122.51430.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 18 Jun 2004 18:28:13 +0200
Message-Id: <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 21:22 +1000, Con Kolivas wrote: 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Patchset update. The focus of this patchset is on system responsiveness with
> emphasis on desktops, but the scope of scheduler changes now makes this patch 
> suitable to servers as well.

I've found some interaction problems between, what I think it's, the
staircase scheduler and swsusp. With vanilla 2.6.7, swsusp is able to
save ~9000 pages to disk in less than 5 seconds, where as 2.6.7-ck1
takes more than 1 minute to save the same amount of pages when
suspending to disk.


