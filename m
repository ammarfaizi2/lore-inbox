Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWHBVt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWHBVt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWHBVt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:49:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55972 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932246AbWHBVt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:49:56 -0400
Subject: Re: make 16C950 UARTs work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       Mathias Adam <a2@adamis.de>
In-Reply-To: <20060802194938.GL5972@redhat.com>
References: <20060802194938.GL5972@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Aug 2006 23:08:56 +0100
Message-Id: <1154556536.23655.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 15:49 -0400, ysgrifennodd Dave Jones:
> This patch has been submitted a number of times, and doesn't seem
> to get any upstream traction, which is a shame, as it seems to work
> for users, and I keep inadvertantly dropping it from the Fedora
> kernel everytime I rebase it.

We really ought to do that based on the PCI subvendor/subdevice id of
the boards in use if possible surely ? It ought to be safe for x86
because nobody is going to use anything but chip default values so they
can avoid needing a ROM.


