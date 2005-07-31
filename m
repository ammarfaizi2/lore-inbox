Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263133AbVGaAPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVGaAPA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVGaANP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:13:15 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:31156 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263128AbVGaALL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:11:11 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Sun, 31 Jul 2005 02:11:01 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Simple question re: oops
Message-ID: <20050731001101.GA6762@localhost.localdomain>
References: <1122767292.4464.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122767292.4464.1.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 07:48:11PM -0400 Lee Revell wrote:

> I have a machine here that oopses reliably when I start X, but the
> interesting stuff scrolls away too fast, and a bunch more Oopses get
> printed ending with "Aieee, killing interrupt handler".
> 
> How do I get the output to stop after the first Oops?
> 

set /proc/sys/kernel/panic_on_oops to 1

What version of the kernel is that? It shouldn't do recursive oopses
(of the same task) any more.
