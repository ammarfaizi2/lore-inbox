Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWISKBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWISKBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 06:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWISKBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 06:01:51 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:59521 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S964959AbWISKBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 06:01:50 -0400
Date: Tue, 19 Sep 2006 17:09:45 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: Don Mullis <dwm@meer.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection capabilities
Message-ID: <20060919090945.GE24271@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain> <20060914102033.462112306@localhost.localdomain> <1158645471.2419.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158645471.2419.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 10:57:51PM -0700, Don Mullis wrote:
> Push fault-injection entries earlier in the list, so that they appear
> nested under DEBUG_KERNEL in menuconfig/xconfig.

Disabling the option Kernel debugging can hide all config options
realated to fault-injection without this patch.

Do I misunderstand something?
