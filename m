Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUDSTlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUDSTlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:41:03 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:4881 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261785AbUDSTlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:41:00 -0400
Date: Mon, 19 Apr 2004 21:39:30 +0200
From: Willy Tarreau <w@w.ods.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: cramerj@intel.com, scott.feldman@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
Message-ID: <20040419193930.GA28340@alpha.home.local>
References: <20040416224422.GA19095@tsunami.ccur.com> <20040417072455.GD596@alpha.home.local> <20040419165425.GA3988@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419165425.GA3988@tsunami.ccur.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, Apr 19, 2004 at 12:54:25PM -0400, Joe Korty wrote:
> 
> Uniprocessor 2.4.26 works fine.
> Uniprocessor 2.4.26 + local apic works fine.
> Uniprocessor 2.4.26 + local apic + io apic fails.

interesting. Unfortunately, I didn't have time to try on the machine I told
you about last day. But right here, I have a dual athlon communicating with
an alpha, both with e1000 (544) in 2.4.26. Since there's a PCI bridge on your
quad, I wonder if the IOAPIC doesn't trigger an interrupt routing problem with
bridges. Are all the ports unusable or do some of them work reliably in APIC
mode ?

Cheers,
Willy

