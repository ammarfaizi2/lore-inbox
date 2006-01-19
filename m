Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWASAVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWASAVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWASAV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:21:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161088AbWASAV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:21:28 -0500
Date: Wed, 18 Jan 2006 19:21:00 -0500
From: Dave Jones <davej@redhat.com>
To: Jes Sorensen <jes@sgi.com>
Cc: pfg@sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16rc1 ia64 missing symbol..
Message-ID: <20060119002100.GJ5278@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jes Sorensen <jes@sgi.com>,
	pfg@sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060117235521.GA14298@redhat.com> <yq0acdtre7e.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0acdtre7e.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 06:02:45AM -0500, Jes Sorensen wrote:
 > >>>>> "Dave" == Dave Jones <davej@redhat.com> writes:
 > 
 > Dave> kernel/drivers/serial/ioc3_serial.ko needs unknown symbol
 > Dave> ioc3_unregister_submodule CONFIG_SERIAL_SGI_IOC3=m
 > Dave> CONFIG_SGI_IOC3=m
 > 
 > Just tried it and it works fine for me:
 > 
 > margin:~ # insmod ioc3.ko
 > margin:~ # insmod ioc3_serial.ko
 > margin:~ # 
 > 
 > This is with the latest git tree from Linus this morning.

I still see problems with the latest Linus tree.

kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_unregister_submodule
kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_disable
kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_gpcr_set
kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_ack
kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_register_submodule
kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_enable
kernel/drivers/pci/hotplug/rpaphp.ko needs unknown symbol pci_claim_resource

full .config at http://people.redhat.com/davej/ia64.config

		Dave
