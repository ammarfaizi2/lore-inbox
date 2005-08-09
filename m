Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVHIHL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVHIHL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVHIHL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:11:26 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:4480 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932452AbVHIHL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:11:26 -0400
Date: Tue, 9 Aug 2005 09:10:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: linux-parport@lists.infradead.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Incorrect permissions on parport sysctls.
In-Reply-To: <20050809044440.GA7725@redhat.com>
Message-ID: <Pine.LNX.4.61.0508090910270.1805@yvahk01.tjqt.qr>
References: <20050809044440.GA7725@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>We have a bunch of 'probe' sysctl's in parport, which are
>readable. (world readable even). Make them write-only.
>Without this, sysctl -a will try to read these files.

Why write-only? Donot you want to read back what you've written there 
sometime? IMO 0600.



Jan Engelhardt
-- 
