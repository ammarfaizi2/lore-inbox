Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbULGLoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbULGLoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbULGLoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:44:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2218 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261792AbULGLoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:44:24 -0500
Date: Tue, 7 Dec 2004 12:43:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Anoop T <moptiva@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: System.map
In-Reply-To: <BAY17-F523A0B2C3BD1F99F9FE23B7B40@phx.gbl>
Message-ID: <Pine.LNX.4.53.0412071242310.18630@yvahk01.tjqt.qr>
References: <BAY17-F523A0B2C3BD1F99F9FE23B7B40@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	In one of the kernel build tutorials I found that I have to link the
>System.map file in /boot to the newly built System.map. But I find that it

It suffices if you copy <path_to_your_tree>/System.map to, say,
/boot/System.map-2.6.9

>is automatically done at start up depending on which kernel version I chose
>to boot. Could anyone please tell who actually does it. I mean is it done by
>the kernel itself or by some start up scripts ?

Well, check your scripts if they do so.



Jan Engelhardt
-- 
ENOSPC
