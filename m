Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVFUUuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVFUUuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVFUUtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:49:09 -0400
Received: from kanga.kvack.org ([66.96.29.28]:39383 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262332AbVFUUrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:47:08 -0400
Date: Tue, 21 Jun 2005 16:48:39 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: William Weston <weston@sysex.net>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050621204839.GC17133@kvack.org>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131009.GA22691@elte.hu> <20050621201742.GA16400@kvack.org> <Pine.LNX.4.58.0506211332080.17025@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506211332080.17025@echo.lysdexia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 01:37:35PM -0700, William Weston wrote:
> No bug warnings on the ns83820, but I did get these messages (last thing 
> that made it syslog):

Normal use should never be triggering a tx timeout, but it was tested back 
when it was written and shouldn't be causing a hang.  What sort of setup 
is this?  You'll probably need a serial console to catch the dieing gasp 
of the kernel, as it will likely be enlightening.

		-ben
