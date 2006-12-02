Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424370AbWLBTII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424370AbWLBTII (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424382AbWLBTII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:08:08 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:12702 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1424370AbWLBTIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:08:05 -0500
Date: Sat, 2 Dec 2006 20:07:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: William Estrada <MrUmunhum@popdial.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
In-Reply-To: <4571CE06.4040800@popdial.com>
Message-ID: <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
References: <4571CE06.4040800@popdial.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I have been trying to make FC5's kernel do a boot with an NFS root file
> system.  I see
> the support is in the kernel(?).  I have tried this:
>
>> root=/dev/nfs nfsroot=10.1.1.12:/tftpboot/NFS/Root_FS

This feature is almost deprecated. One is supposed to use initramfs,
/sbin/ip or some DHCP client, and a mount program nowadays.


	-`J'
-- 
