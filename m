Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267795AbUHJWpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267795AbUHJWpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267797AbUHJWpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:45:45 -0400
Received: from digitalimplant.org ([64.62.235.95]:38870 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267795AbUHJWoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:44:17 -0400
Date: Tue, 10 Aug 2004 15:44:07 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: David Brownell <david-b@pacbell.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <200408101241.39720.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.50.0408101543060.28789-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
 <200408101241.39720.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, David Brownell wrote:

> Suspending a partial tree is part of the "device power management"
> problem ... it's not a policy, and deferring it would punt on one of
> the more basic problems.

I suppose I should ask whether or not its worth doing in the kernel. Can
you simply suspend the subtree using a properly implemented sysfs
interface and the runtime power management hooks?


	Pat
