Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVBQGVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVBQGVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVBQGVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:21:48 -0500
Received: from colin2.muc.de ([193.149.48.15]:17931 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262240AbVBQGVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:21:35 -0500
Date: 17 Feb 2005 07:21:30 +0100
Date: Thu, 17 Feb 2005 07:21:30 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: node_to_cpumask  x86_64 broken
Message-ID: <20050217062130.GA21305@muc.de>
References: <3174569B9743D511922F00A0C943142308085989@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142308085989@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 10:30:51PM -0800, YhLu wrote:
> forget about it. I found the reason:  I only put node 0 has RAM installed.

There is some problem with this code - it complains on a few machines.
However it's relatively harmless when this happens, so I haven't looked
it yet. Should perhaps take out the printk.

-Andi
