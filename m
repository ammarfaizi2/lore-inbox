Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVJ3MkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVJ3MkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVJ3Mj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:39:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16519 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932156AbVJ3Mjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:39:53 -0500
Date: Sat, 29 Oct 2005 09:55:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [PATCH] driver model wakeup flags
Message-ID: <20051029075540.GA2579@openzaurus.ucw.cz>
References: <11304810223093@kroah.com> <1130481022955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130481022955@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   * There's a writeable sysfs "wakeup" file, with one of two values:
>       - "enabled", when the policy is to allow wakeup
>       - "disabled", when the policy is not to allow it
>       - "" if the device can't currently issue wakeups

Could we either get "not-supported" value here, or remove the file if it is not
supported? Having empty file is ugly...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

