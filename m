Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265729AbUGHBct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUGHBct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGHBct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:32:49 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24779 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265729AbUGHBcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:32:47 -0400
Date: Wed, 7 Jul 2004 21:35:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Robert Horton <trebor@agarithil-nost.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.7 hangs..
In-Reply-To: <44108A2B-D066-11D8-8BAE-0003933EE6DC@agarithil-nost.com>
Message-ID: <Pine.LNX.4.58.0407072134160.6434@montezuma.fsmlabs.com>
References: <44108A2B-D066-11D8-8BAE-0003933EE6DC@agarithil-nost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Robert Horton wrote:

> I have recently completed building a LFS (linux from scratch) system
> which uses the 2.6.7 kernel on a i686 machine. Upon reboot the systems
> hangs after the BIOS RAM mapping. Specifically:
>
> -snip-
> 511MB LOWMEM available
> On node 0 totalpages: 131056
> 	DMA zone: 4096 pages, LIFO batch: 1
> 	Normal zone: 126960 pages, LIFO batch: 16
> 	HighMem zone: 0 pages, LIFO batch: 1
>
>
> and that is as far as it goes unless it takes an inordinate amount of
> time to continue past that point. I did leave it for approximately four
> minutes and had no further progression.
>
> I searched the archives and while I did not find anything pertaining
> this I did see that the next logical progression deals with DMI and
> ACPI so I do not know if it is hanging at the memory portion or the
> next portion.

Try booting with acpi=off
