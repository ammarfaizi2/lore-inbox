Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267532AbUHPLLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267532AbUHPLLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267531AbUHPLLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:11:10 -0400
Received: from karnickel.franken.de ([193.141.110.11]:22789 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S267535AbUHPLKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:10:10 -0400
Subject: Re: 2.6.8.1 Oops after raid1 disk failure
From: Erik Tews <erik@debian.franken.de>
To: David R <spam.david.trap@unsolicited.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <411FD307.4000102@unsolicited.net>
References: <411FD307.4000102@unsolicited.net>
Content-Type: text/plain
Message-Id: <1092654273.3452.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 13:04:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 15.08.2004 schrieb David R um 23:17:
> I got the following Oops (attached) after a drive failed in my raid1 
> pair. I'm assuming the kernel shouldn't really do this as the other 
> drive was ok?

Hi

I see no raid-related parts in the backtrace, so the error seems to be
somewhere in the ide-layer.

