Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbTL3TVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbTL3TVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:21:17 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:4017 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265898AbTL3TVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:21:14 -0500
Date: Tue, 30 Dec 2003 11:21:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dom <binary1230@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: 2.4.22 processes occasionally segfault, kernel crashes, machine reboots
Message-ID: <20031230192108.GW1882@matchmail.com>
Mail-Followup-To: Dom <binary1230@yahoo.com>, linux-kernel@vger.kernel.org
References: <20031230190822.88961.qmail@web40210.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230190822.88961.qmail@web40210.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 11:08:22AM -0800, Dom wrote:
> [1.] (seemingly random?) processes occasionally
> segfault, kernel crashes, machine reboots

I'd suggest you run memtest86 on it ASAP since zap_page_range is a very
often used function in the kernel, and very unlikely to have bugs in it, and
more likely to find hardware problems.

Also check your:
 o cooling
 o power supply
 o cables
