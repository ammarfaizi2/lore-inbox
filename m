Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVC0BYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVC0BYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 20:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVC0BYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 20:24:08 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:994 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261453AbVC0BYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 20:24:05 -0500
Date: Sat, 26 Mar 2005 17:23:22 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gettimeofday call
Message-ID: <20050327012322.GA6803@taniwha.stupidest.org>
References: <Pine.LNX.4.61.0503261139490.3958@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503261139490.3958@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 11:40:27AM +0100, Jan Engelhardt wrote:

> I suppose that calling gettimeofday() repeatedly (to add a timestamp
> to some data) within the kernel is cheaper than doing it in
> userspace, is it?

Calls to do_gettimeofday are used in various places for this already.
See sock_get_timestamp for example.
