Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWJMSlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWJMSlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWJMSlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:41:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751799AbWJMSlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:41:44 -0400
Date: Fri, 13 Oct 2006 11:41:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: neilb@suse.de, rusty@rustcorp.com.au,
       "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: +
 convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
 added to -mm tree
Message-Id: <20061013114132.9e5afab9.akpm@osdl.org>
In-Reply-To: <452FAE74.1020500@googlemail.com>
References: <200610130506.k9D56YJY031111@shell0.pdx.osdl.net>
	<452FAE74.1020500@googlemail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 17:19:16 +0200
Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> There is something really wrong with this patch (or my hardware).
> 
> echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> works fine for me on 2.6.19-rc1-g8770c018.
> 
> On 2.6.19-rc1-mm1 +
> convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
> + Neil's avoid_lockdep_warning_in_md.patch
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0642.html)
> I get a lot of "end_request: I/O error, dev sda, sector 31834343" messages.

That's not exactly an expected result.  What makes you think it's due to
this patch?  Does 2.6.19-rc1-mm1 run OK?

