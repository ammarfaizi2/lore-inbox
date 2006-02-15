Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423008AbWBOHX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423008AbWBOHX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423010AbWBOHX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:23:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423008AbWBOHX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:23:27 -0500
Date: Tue, 14 Feb 2006 23:22:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: elezeta@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Problems with sound on latest kernels.
Message-Id: <20060214232222.1016fe87.akpm@osdl.org>
In-Reply-To: <1139934640.11659.95.camel@mindpipe>
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
	<1139934640.11659.95.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Tue, 2006-02-14 at 14:58 +0100, Lz wrote:
> > Hello,
> > 
> > I can't manage to get my sound cards (SB VIBRA and SB AWE 32) working
> > on the latest kernels (> 2.6.14 approximately).
> > 
> 
> Please use ALSA CVS to do a binary search by date to identify the change
> that broke it.
> 

Poor guy - that's rocket science.  It looks like it's due to breakage in
the pnp code anwyay.

Please set CONFIG_PNP_DEBUG=y and send us the output of `dmesg -s 1000000',
thanks.
