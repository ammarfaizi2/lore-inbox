Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUFFRkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUFFRkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFFRkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:40:06 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:50694 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263868AbUFFRkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:40:02 -0400
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <200406070139.38433.kernel@kolivas.org>
References: <200406070139.38433.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1086543600.1700.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Sun, 06 Jun 2004 19:40:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 17:39, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This is an update of the scheduler policy mechanism rewrite using the 
> infrastructure of the current O(1) scheduler. Slight changes from the 
> original design require a detailed description. The change to the original 
> design has enabled all known corner cases to be abolished and cpu 
> distribution to be much better maintained. It has proven to be stable in my 
> testing and is ready for more widespread public testing now.

I'm impressed... I'm currently playing with linux-2.6.7-rc2-bk7 plus
staircase plus autoswappiness and my system behaves exceptionally. It
seems pretty responsive even when under heavy load (while true; do a=2;
done). Nice work.

