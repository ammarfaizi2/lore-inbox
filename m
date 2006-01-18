Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWARLCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWARLCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWARLCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:02:53 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:3215 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1030214AbWARLCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:02:53 -0500
To: Dave Jones <davej@redhat.com>
Cc: pfg@sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16rc1 ia64 missing symbol..
References: <20060117235521.GA14298@redhat.com>
From: Jes Sorensen <jes@sgi.com>
Date: 18 Jan 2006 06:02:45 -0500
In-Reply-To: <20060117235521.GA14298@redhat.com>
Message-ID: <yq0acdtre7e.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@redhat.com> writes:

Dave> kernel/drivers/serial/ioc3_serial.ko needs unknown symbol
Dave> ioc3_unregister_submodule CONFIG_SERIAL_SGI_IOC3=m
Dave> CONFIG_SGI_IOC3=m

Just tried it and it works fine for me:

margin:~ # insmod ioc3.ko
margin:~ # insmod ioc3_serial.ko
margin:~ # 

This is with the latest git tree from Linus this morning.

Cheers,
Jes
