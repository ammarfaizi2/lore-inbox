Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUKNWbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUKNWbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKNWbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:31:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:50923 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261356AbUKNWbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:31:03 -0500
Date: Sun, 14 Nov 2004 14:30:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brad Fitzpatrick <brad@danga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9: unkillable processes during heavy IO
Message-Id: <20041114143051.33e2c514.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411141403040.22805@danga.com>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Fitzpatrick <brad@danga.com> wrote:
>
> Next time it hangs like this, how can I get a kernel backtrace or other useful information
>  for a certain process?

echo t > /proc/sysrq-trigger
dmesg -n 1000000 > foo

then send foo.
