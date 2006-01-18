Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWARBOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWARBOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWARBOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:14:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932442AbWARBOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:14:37 -0500
Date: Tue, 17 Jan 2006 17:14:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1 -- which gcc version?
In-Reply-To: <Pine.LNX.4.64.0601180810270.29057@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.64.0601171712590.3240@g5.osdl.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
 <20060117183916.399b030f.diegocg@gmail.com> <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
 <Pine.LNX.4.64.0601180810270.29057@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jan 2006, Jeff Chua wrote:
> 
> Which gcc version should I use, now that gcc-2.95.3 can't compile
> 2.6.16-rc1 anymore? gcc-3.3 as mentioned in the patch?

Avoid 4.0.0 and 4.0.1, but other than that, I don't think there are really 
any huge mistakes to be made. You'll be very hard-pressed to even find any 
of the old buggy early-3.x series compilers.

		Linus
