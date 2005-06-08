Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVFHAIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVFHAIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 20:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVFHAIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 20:08:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:57302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262048AbVFHAIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 20:08:11 -0400
Date: Tue, 7 Jun 2005 17:08:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-Id: <20050607170853.3f81007a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com>
References: <1004450000.1118188239@flay>
	<20050607165656.2517b417.akpm@osdl.org>
	<Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Tue, 7 Jun 2005, Andrew Morton wrote:
> 
> > > Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
> > 
> > Oh crap, so it does.  That's wrong.
> 
> Email by you and Linus indicated that 250 should be the default.

Oh, OK. hrm.

Martin, it would be useful if you could determine whether the kernbench
slowdown was due to the 1000Hz->250Hz change, thanks.

I'm assuming it was the CPU scheduler patches.  There are 36 of them ;)
