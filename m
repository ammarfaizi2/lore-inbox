Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292657AbSBUR0Z>; Thu, 21 Feb 2002 12:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292658AbSBUR0Q>; Thu, 21 Feb 2002 12:26:16 -0500
Received: from www.wen-online.de ([212.223.88.39]:55044 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S292657AbSBUR0F>;
	Thu, 21 Feb 2002 12:26:05 -0500
Date: Thu, 21 Feb 2002 18:37:21 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Joe Wong <joewong@tkodog.no-ip.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: detect memory leak tools?
In-Reply-To: <Pine.LNX.4.33.0202211531440.5429-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10202211823360.735-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Joe Wong wrote:

> Hi,
> 
>   Is there any tools that can detect memory leak in kernel loadable 
> module?

Depends which kernel version.. <= 2.4.9, you can use IKD, which
contains Ingo's memleak detector.  Sadly, it's unmaintained atm.

See /pub/linux/kernel/people/andrea/ikd of your favorite mirror
to see if there's a canned version that fits your needs.  (If not,
it's likely easier to rip memleak out of ikd and hand patch than
to try fixing the zillion rejects you'd have if you try to wedge
ikd into a recent tree:)

	-Mike

