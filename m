Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUHONBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUHONBw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 09:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUHONBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 09:01:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15838 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266682AbUHONBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 09:01:44 -0400
Subject: Re: external drive size differences
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040815093759.GK31901@lbsd.net>
References: <20040815093759.GK31901@lbsd.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092571159.17605.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 Aug 2004 12:59:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-15 at 10:37, Nigel Kukard wrote:
> Something very very interesting... below is an external drive enclosure
> supporting both USB2 and Firwire, fitted with a 200Gb IDE Hdd.
> 
> When plugged into the firewire bus, i get 137Gb size, when plugged into
> the usb bus, i get 200Gb size.
> 
> Could this be a bug in the kernel? or external hardware?

Your firewire adapter doesn't support large drives I would suspect.
137Gb is the exact limit of a non LBA48 aware adapter.

