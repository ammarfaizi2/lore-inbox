Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755045AbWKRP27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbWKRP27 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 10:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbWKRP27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 10:28:59 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:10951 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1754817AbWKRP26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 10:28:58 -0500
Date: Sat, 18 Nov 2006 16:28:12 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: sleeping functions called in invalid context during resume
Message-ID: <20061118162812.1cd8b0f0@localhost>
In-Reply-To: <200611181355.04355.fzu@wemgehoertderstaat.de>
References: <20061114223002.10c231bd@localhost.localdomain>
	<20061117083008.7758149a@localhost.localdomain>
	<20061118124349.16743124@localhost>
	<200611181355.04355.fzu@wemgehoertderstaat.de>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006 13:55:04 +0100
Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
>
> Could you try the following, as of yet untested patch?
> It's i386 twin makes an APIC error vanish here on a K8.
> 
>       Karsten
> -----------------------------------------------------------------------
> From 54248a43231de8d6d64354b51646c54121e3f395 Mon Sep 17 00:00:00 2001
> From: Karsten Wiese <fzu@wemgehoertderstaat.de>
> Date: Sat, 18 Nov 2006 13:44:14 +0100
> Subject: [PATCH 1/1] x86_64: Regard MSRs in lapic_suspend()/lapic_resume()


It works!	:)

-- 
	Paolo Ornati
	Linux 2.6.19-rc6-ge030f829-dirty on x86_64
