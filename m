Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbUDQH2H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 03:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUDQH2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 03:28:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55306 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263705AbUDQH2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 03:28:04 -0400
Date: Sat, 17 Apr 2004 09:24:56 +0200
From: Willy Tarreau <w@w.ods.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: Linux NICS <linux.nics@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
Message-ID: <20040417072455.GD596@alpha.home.local>
References: <20040416224422.GA19095@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416224422.GA19095@tsunami.ccur.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 06:44:22PM -0400, Joe Korty wrote:
> The e1000 driver fails to operate an Intel PRO/1000 MT Quad Port Server
> Adaptor under the latest 2.4.26+bk with CONFIG_SMP=y.  It works fine
> when CONFIG_SMP=n.

Did you enable APIC in UP mode, and did you try with an SMP kernel booted
with the 'nosmp' option ? Have you tried with plain 2.4.26 too ? There were
e1000 changes in latest bk.

I'm interested in trying this, because I know of a firewall appliance which
is based on a dell with 2 xeon HT and which has 2 of these cards. I might
try to boot it on a linux CD on monday if I find some time. Could you post
your config ?

Regards,
Willy

