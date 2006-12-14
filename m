Return-Path: <linux-kernel-owner+w=401wt.eu-S932700AbWLNMhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWLNMhv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWLNMhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:37:51 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:56579 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932700AbWLNMhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:37:50 -0500
Date: Thu, 14 Dec 2006 13:37:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Userspace I/O driver core
In-Reply-To: <20061214010608.GA13229@kroah.com>
Message-ID: <Pine.LNX.4.61.0612141335040.6223@yvahk01.tjqt.qr>
References: <20061214010608.GA13229@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The patches can be found in the -mm releases or at:
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio.patch
>    - UIO core
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-documentation.patch
>    - UIO documentation
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-dummy.patch
>  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/uio-irq.patch
>    - two example kernel modules and userspace programs showing how to
>      use the UIO interface.
>
>If anyone has any questions on how to use this interface, or anything
>else about it, please let me and Thomas know.

The uio-irq.patch contains SA_INTERRUPT in its code. I thought this flag was
obsoleted by IRQF_* by now?



	-`J'
-- 
