Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265548AbUFON6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUFON6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUFON6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:58:44 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:60085 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S265548AbUFON6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:58:41 -0400
Message-ID: <40CF0049.2010307@pacbell.net>
Date: Tue, 15 Jun 2004 06:57:29 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Gary_Lerhaupt@Dell.com
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Stuart_Hayes@Dell.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
References: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com>
In-Reply-To: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gary_Lerhaupt@Dell.com wrote:
> Stuart Hayes here at Dell has identified this or/and mix-up in the
> ehci-hcd driver.  Because of this, ehci-hcd is not properly released by
> BIOSes supporting full 2.0 and port behavior can then become erratic.

Good patch, it should be merged.  That handoff code actually
predates general availability of BIOSes handling _any_ EHCI
controllers, and your patch resolves a problem I'd seen on a
newish board but hadn't yet had time to track down (beyond
knowing that broken BIOS handoff was the issue).

Thanks to you and Stuart!

- Dave






