Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVIHXac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVIHXac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVIHXac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:30:32 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:14261 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965070AbVIHXab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:30:31 -0400
Subject: Re: [GIT PATCH] W1 patches for 2.6.13
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru
In-Reply-To: <20050908222105.GA6633@kroah.com>
References: <20050908222105.GA6633@kroah.com>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 01:30:09 +0200
Message-Id: <1126222209.5286.74.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Here are some w1 patches that have been in the -mm tree for a while.
> They add a new driver, and fix up the netlink logic a lot.  They also
> add a crc16 implementation that is needed.

adding the CRC-16 is very cool. I was just about to submit one by my
own, because it is also needed for the Bluetooth L2CAP retransmission
and flow control support.

What about the 1-Wire notes inside the CRC-16 code. This suppose to be
generic code and so this doesn't belong there.

Regards

Marcel


