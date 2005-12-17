Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVLQAYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVLQAYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVLQAYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:24:40 -0500
Received: from main.gmane.org ([80.91.229.2]:42465 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932552AbVLQAYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:24:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: 2.6.15-rc5-rt2 slowness
Date: Sat, 17 Dec 2005 01:22:35 +0100
Message-ID: <dnvlo7$5rm$1@sea.gmane.org>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134736325.13138.119.camel@localhost.localdomain> <1134773902.27117.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.117.85.179
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Do check that the slowness you're seeing isn't related to the
> CONFIG_PARANIOD_GENERIC_TIME option being enabled. It is expected that
> the extra checks made by that config option would slow things down a
> bit.

The first kernel I built which showed this behaviour had no debugging
options enabled.

It happens if the system is mostly idle, in this state "top" will show a
kernel usage of 20%-50%, and as soon as something cpu intensive is started,
the whole system becomes extremely unresponsive.

Greetings,

  Gunter

