Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUCPWBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUCPWBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:01:16 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:48325 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261746AbUCPWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:01:13 -0500
Date: Tue, 16 Mar 2004 17:01:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Francis F Steen <steen@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 ifdown race
In-Reply-To: <4057709A.8080808@cogweb.net>
Message-ID: <Pine.LNX.4.58.0403161659330.28447@montezuma.fsmlabs.com>
References: <4057709A.8080808@cogweb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Francis F Steen wrote:

> In kernel 2.6.3, if I take down the network connection, within a second
> or so top shows 99.9% CPU utilization for [events/0].
> When I restablish a network connection, it calms down at once.
>
> I had the same behavior in 2.6.0.
>
> Details below -- what can I do to get more information on what is happening?

Compile in CONFIG_MAGIC_SYSRQ and then when the load goes up do;

alt + syrq + t

you're interested in the call traces from events/0

