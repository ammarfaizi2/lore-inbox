Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbUKCVDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUKCVDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUKCU7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:59:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261883AbUKCU4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:56:50 -0500
Date: Wed, 3 Nov 2004 12:56:27 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Test patch for ub and double registration
Message-ID: <20041103125627.0224f431@lembas.zaitcev.lan>
In-Reply-To: <200411032143.02197.cova@ferrara.linux.it>
References: <20041101164432.3fa72b81@lembas.zaitcev.lan>
	<200411022257.24752.cova@ferrara.linux.it>
	<20041102151044.4270bc12@lembas.zaitcev.lan>
	<200411032143.02197.cova@ferrara.linux.it>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004 21:43:01 +0100, Fabio Coatti <cova@ferrara.linux.it> wrote:

> Nov  3 21:36:26 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
> and address 4
> Nov  3 21:36:26 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
> failed with status 440000
> Nov  3 21:36:26 kefk kernel: [f7a6c240] link (37a6c1b2) element (37a6b040)
> Nov  3 21:36:26 kefk kernel:   0: [f7a6b040] link (37a6b080) e0 Stalled 
> CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=37c882a0)
> Nov  3 21:36:26 kefk kernel:   1: [f7a6b080] link (37a6b0c0) e3 SPD Active 
> Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=1cd988c0)
> Nov  3 21:36:26 kefk kernel:   2: [f7a6b0c0] link (00000001) e3 IOC Active 
> Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
> Nov  3 21:36:26 kefk kernel:
> Nov  3 21:36:26 kefk kernel: usb 2-1: device descriptor read/64, error -71

So, this fails even before getting to ub. I don't know how to help this,
but perhaps Greg has any ideas. I'm afraid I would just reboot if weird
things like this start happening. I hope your device hasn't just died
suddenly...

-- Pete
