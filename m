Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUCUGRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 01:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbUCUGRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 01:17:12 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:62382 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263609AbUCUGRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 01:17:11 -0500
Date: Sat, 20 Mar 2004 22:17:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa3
Message-ID: <2910700000.1079849836@[10.10.2.4]>
In-Reply-To: <20040320210306.GA11680@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixed the sigbus in nopage and improved the page_t layout per Hugh's
> suggestion. BUG() with discontigmem disabled if somebody returns non-ram
> via do_no_page, that cannot work right on numa anyways.

OK, well it doesn't oops any more. But sshd still dies as soon as it starts,
so accessing the box is tricky ;-) And now I have no obvious diagnostics
either ...

M.

