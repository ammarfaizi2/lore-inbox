Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTJ1VP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTJ1VP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:15:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59533 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261776AbTJ1VPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:15:25 -0500
Date: Tue, 28 Oct 2003 16:18:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test8-mm1]: trashing and oops() on OOM (WARNING: VMware
 modules loaded)
In-Reply-To: <20031028210657.GA2204@localhost>
Message-ID: <Pine.LNX.4.53.0310281616210.24565@chaos>
References: <20031028210657.GA2204@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since every process seems to OOPS, you should find out what module
is causing the "Tainted" response, remove it, and see if that "fixes"
it. That module may not be up-to-date with your current kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


