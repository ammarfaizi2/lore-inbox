Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbULUQnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbULUQnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULUQnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:43:46 -0500
Received: from fsmlabs.com ([168.103.115.128]:4021 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261802AbULUQna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:43:30 -0500
Date: Tue, 21 Dec 2004 09:43:38 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-bk13: Badness in smp_call_function at arch/i386/kernel/smp.c:523
In-Reply-To: <200412211731.51243.gluk@php4.ru>
Message-ID: <Pine.LNX.4.61.0412210943030.28648@montezuma.fsmlabs.com>
References: <200412211731.51243.gluk@php4.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004, Alexander Y. Fomichev wrote:

> I've got it on Dual AthlonMP 2200+ ( 4G RAM, LSI320-1 ) under heavy load 
> ( load avarage > 100 i guess ) just after Emergency Sync and SysRq Boot
> 
> bo.srv.ehouse.ru login: SysRq : Changing Loglevel
> Loglevel set to 6
> SysRq : Emergency Sync
> SysRq : Emergency Sync
> SysRq : Resetting
> Badness in smp_call_function at arch/i386/kernel/smp.c:523

Thanks for reporting it, there is a fix already which should be in before 
2.6.10.

	Zwane

