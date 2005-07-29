Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVG2UiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVG2UiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVG2Ufs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:35:48 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:27794 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262800AbVG2Ufe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:35:34 -0400
Date: Fri, 29 Jul 2005 22:34:04 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why dump_stack results different so much?
Message-ID: <20050729203403.GA30603@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
References: <4ae3c140507291327143a9d83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140507291327143a9d83@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 04:27:16PM -0400, Xin Zhao wrote:
> I supprisely noticed that the dump_stack results are quite different!
> Why did I get the calling traces below our_ssy_open() and above
> syscall_call()?  Any thought on this? Many thanks!

This might depend on compiling with frame pointers, or not. I recall that at
one point, the kernel did a basic scan of addresses that looked like likely
candidates to have been pointers, and printed those.

Frame pointers are hailed as improving backtraces. They are in the 'kernel
hacking' section of the kernel configuration.

Sorry that I can't be more precise, but try turning on frame pointers.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
