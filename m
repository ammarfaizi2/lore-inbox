Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbULNRbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbULNRbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbULNRbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:31:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14997 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261570AbULNRbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:31:18 -0500
Date: Tue, 14 Dec 2004 18:31:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: how to add 32/64 compatible ioctls at runtime via module?
In-Reply-To: <200412141727.iBEHRcaj012562@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.61.0412141830450.5600@yvahk01.tjqt.qr>
References: <200412141727.iBEHRcaj012562@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>register_ioctl32_conversion(ioctl, handler)
>
>tells your 64-bit kernel that the given ioctl, when issued by
>a 32-bit mode task, should be routed to the given handler.

Hah, so there is a way to determine whether a task is 32/64-bit? That could 
solve the problem of one of the recent posters...


Jan Engelhardt
-- 
ENOSPC
