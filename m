Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUFFW7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUFFW7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUFFW7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 18:59:08 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:20153 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264225AbUFFW6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 18:58:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Date: Mon, 7 Jun 2004 08:58:32 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
References: <200406070139.38433.kernel@kolivas.org> <1086543600.1700.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1086543600.1700.2.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406070858.32924.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 03:40, Felipe Alfaro Solana wrote:
> On Sun, 2004-06-06 at 17:39, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > This is an update of the scheduler policy mechanism rewrite using the
> > infrastructure of the current O(1) scheduler. Slight changes from the
> > original design require a detailed description. The change to the
> > original design has enabled all known corner cases to be abolished and
> > cpu distribution to be much better maintained. It has proven to be stable
> > in my testing and is ready for more widespread public testing now.
>
> I'm impressed... I'm currently playing with linux-2.6.7-rc2-bk7 plus
> staircase plus autoswappiness and my system behaves exceptionally. It
> seems pretty responsive even when under heavy load (while true; do a=2;
> done). Nice work.

Sounds good.

Thanks for testing.

Con
