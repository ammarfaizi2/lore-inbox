Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUCBQLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 11:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUCBQLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 11:11:33 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:40948 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S261690AbUCBQLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 11:11:32 -0500
To: David Bryson <david@tsumego.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: circular pivot_root, is this possible ?
In-Reply-To: <1v7Zf-5EG-5@gated-at.bofh.it>
References: <1v7Zf-5EG-5@gated-at.bofh.it>
Date: Tue, 2 Mar 2004 17:11:26 +0100
Message-Id: <E1AyCUQ-00004T-N0@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2004 03:40:09 +0100, you wrote in linux.kernel:

> Say the system needs an upgrade.... I want to
>
> 1) pivot_root _back out_ of the tmpfs, onto the initrd again
> 2) obtain via network a new sys.img, write it to the flash
> 3) wipe tmpfs, and recopy the contents of the new sys.img into memory
> 4) pivot_root back into the tmpfs and start the higher level system
> again

How about using a second, small tmpfs for / under/over which the tmpfs
for the full system can be mounted and umounted at will?

-- 
Ciao,
Pascal
