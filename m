Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbULKOuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbULKOuj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 09:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbULKOuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 09:50:39 -0500
Received: from fsmlabs.com ([168.103.115.128]:28608 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261938AbULKOuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 09:50:37 -0500
Date: Sat, 11 Dec 2004 07:50:31 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <20041211142317.GF16322@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412110749070.5214@montezuma.fsmlabs.com>
References: <20041211142317.GF16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, Andrea Arcangeli wrote:

> This patch is quite intrusive since many HZ visible to userspace have to
> be converted to USER_HZ, and most important because HZ isn't available

Shouldn't that be a bug anyway regardless of dynamic-hz?
