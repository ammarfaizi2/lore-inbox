Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbTLKHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTLKHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:07:25 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:28547 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264345AbTLKHHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:07:24 -0500
Date: Wed, 10 Dec 2003 23:07:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <1288980000.1071126438@[10.10.2.4]>
In-Reply-To: <1071122742.5149.12.camel@idefix.homelinux.org>
References: <1071122742.5149.12.camel@idefix.homelinux.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this may be of interest to some people. I've attached a patch
> that makes it possible to increase HZ up to 10000. The patch adds some
> HZ-related defines (e.g. SHIFT_HZ) for higher HZ values. It also removes
> some shift by negative number and divide by zero (e.g. in bogomips
> computation) and prevents some overflows. I'm not sure I fixed
> everything, but right now it seems to work with HZ=10000. The only thing
> I'm seeing are messages such as: "orinoco_lock() called with
> hw_unavailable (dev=f75c8000)" and "eth1: IRQ handler is looping too
> much! Resetting.".

Why would you want to *increase* HZ? I'd say 1000 is already too high
personally, but I'm curious what you'd want to do with it? Embedded
real-time stuff?

M.

