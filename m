Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWISKAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWISKAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 06:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWISKAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 06:00:21 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:50557 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S964954AbWISKAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 06:00:19 -0400
Date: Tue, 19 Sep 2006 17:08:13 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection capabilities
Message-ID: <20060919090813.GD24271@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain> <20060914102033.462112306@localhost.localdomain> <1158645388.2419.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158645388.2419.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 10:56:28PM -0700, Don Mullis wrote:
> Fix bug in !(CONFIG_STACK_UNWIND || CONFIG_STACKTRACE) case, based on
> code inspection only.  Anyone with a non-i386, -x86_64, -s390 willing
> to test this?

Yes, it didn't work completely without this patch on other architectures.
Thank you.
