Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTLUSHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 13:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLUSHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 13:07:20 -0500
Received: from linux-bt.org ([217.160.111.169]:27050 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263618AbTLUSHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 13:07:19 -0500
Subject: Re: Difference between select and enable in Kconfig
From: Marcel Holtmann <marcel@holtmann.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Randy Dunlap <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312211830260.27544@serv>
References: <1071974814.2684.41.camel@pegasus>
	 <20031220205433.195037e8.rddunlap@osdl.org>
	 <1072027326.2684.72.camel@pegasus> <Pine.LNX.4.58.0312211830260.27544@serv>
Content-Type: text/plain
Message-Id: <1072029989.2684.76.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 19:06:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

> > so both options achieve the same result. Why do we have two different
> > options for the same stuff? Should we not remove one?
> 
> It was called first 'enable' and later renamed into 'select', which is now
> the official version, so 'enable' could be indeed removed.

thanks for the clarification and I have choosen the wrong one. After a
quick grep through the kernel sources I found that

	drivers/net/wireless/Kconfig

is the only file that uses the enable option and of course this was the
example I have looked at :(

Regards

Marcel


