Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUG2IKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUG2IKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267191AbUG2IKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:10:41 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:19881 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266914AbUG2IKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:10:38 -0400
Subject: Re: -mm swsusp: do not default to platform/firmware
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Li, Shaohua" <shaohua.li@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729073821.GA828@elf.ucw.cz>
References: <B44D37711ED29844BEA67908EAF36F03712639@pdsmsx401.ccr.corp.intel.com>
	 <20040729073821.GA828@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091088227.8873.147.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 18:03:48 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 17:38, Pavel Machek wrote:
> Threads that are "NOFREEZE" should be carefull not to do anything bad
> to drivers, and if it works as NOFREEZE for swsusp, it will work in
> S3, too. No need to do additional work of freezing based on new state.

Yes. It helps to remember that even if they're NOFREEZE, they'll still
be affected by the driver suspending and resuming that's done in both S3
(I assume) and S4 support.

Regards,

Nigel

