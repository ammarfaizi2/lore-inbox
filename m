Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVAHXz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVAHXz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVAHXz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:55:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:3239 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262083AbVAHXzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:55:49 -0500
Date: Sat, 8 Jan 2005 15:55:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andre Eisenbach <int2str@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X applications don't run with 2.6.10-mm2
Message-Id: <20050108155532.32d374ee.akpm@osdl.org>
In-Reply-To: <7f800d9f050108140116a8f2c3@mail.gmail.com>
References: <7f800d9f050108140116a8f2c3@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Eisenbach <int2str@gmail.com> wrote:
>
>  After updrading from linux-2.6.10-rc2-mm3 to linux-2.6.10-mm2, X
>  windows applications (any) would not start anymore. Not even Xterm.

Yes, there's been some breakage in both the AGP and ioctl areas.  Please
retest -mm3 when it's available.
