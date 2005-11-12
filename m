Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVKLChB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVKLChB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVKLChA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:37:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34454 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751334AbVKLCg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:36:59 -0500
Subject: Re: CM8738 audio hampering while playing video on G450 PCI graphic
	card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511120241.54383.mark.hurenkamp@xs4all.nl>
References: <200511120241.54383.mark.hurenkamp@xs4all.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Nov 2005 03:08:15 +0000
Message-Id: <1131764895.3174.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-12 at 02:41 +0100, Mark Hurenkamp wrote:
> Now whenever there's a lot of activety (like scrolling down when I'm
> browsing on a news site like slashdot, or playing video) on the G450 (both in 
> accelerated mode, as well as in unaccelerated framebuffer mode), the audio 
> (onboard CMedia) starts to hamper. This happens regardless wether I'm using

Its a hardware feature although X should be defaulting to avoid this
problem. Try

	Option "PCIRetry" "off"

in your xorg.conf

