Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTFGGcw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFGGcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:32:52 -0400
Received: from vitelus.com ([64.81.243.207]:7953 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S262153AbTFGGcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:32:52 -0400
Date: Fri, 6 Jun 2003 23:45:07 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607064507.GJ22716@vitelus.com>
References: <20030607063424.GA12616@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607063424.GA12616@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 08:34:24AM +0200, Andi Kleen wrote:
> I finally got sick of seeing bug reports from people who did not enable
> CONFIG_VT or forgot to enable the obscure options for the keyboard
> driver. This is especially a big problem for people who do make oldconfig
> with a 2.4 configuration, but seems to happen in general often.
> I also included the PS/2 mouse driver. It is small enough and a useful
> fallback on any PC.

Can't these just be made the default and have oldconfig default to the
defaults (does it?). Seems silly to force people to jump through hoops
if they don't want to compile in something (i.e. they use a USB
mouse).
