Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269211AbUHaWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269211AbUHaWBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUHaWAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:00:42 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:16314 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269162AbUHaV6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:58:40 -0400
Date: Tue, 31 Aug 2004 14:58:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@ximian.com>
Cc: greg@kroah.com, akpm@osdl.org, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040831215831.GA3573@taniwha.stupidest.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093988576.4815.43.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 05:42:56PM -0400, Robert Love wrote:

> 	send_kevent(KEVENT_POWER, NULL, kobj, "overheating");

I *still* thinking putting all the possible messages into something
like include/linux/kevent_msg.h is a good idea to prevent people
creating all sorts of stupid ad-hoc messages over time that userspace
will ineviitably not be able to track....


  --cw
