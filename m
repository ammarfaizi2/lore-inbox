Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269293AbUJKWRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269293AbUJKWRC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJKWRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:17:01 -0400
Received: from cantor.suse.de ([195.135.220.2]:1441 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269299AbUJKWQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:16:53 -0400
Message-ID: <416B0557.40407@suse.de>
Date: Tue, 12 Oct 2004 00:12:39 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org
Subject: Re: Totally broken PCI PM calls
References: <1097455528.25489.9.camel@gaston> <200410110936.37268.david-b@pacbell.net> <1097529469.4523.3.camel@desktop.cunninghams> <200410111437.17898.david-b@pacbell.net>
In-Reply-To: <200410111437.17898.david-b@pacbell.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

> The machines I've tested with relatively generic 2.6.9-rc kernels
> don't use BIOS support for S4 when I call swsusp.

first do either
echo platform > /sys/power/disk     # for S4
echo shutdown > /sys/power/disk     # for poweroff

then do
echo disk > /sys/power/state


      Stefan
