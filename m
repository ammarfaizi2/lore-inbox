Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUF3M02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUF3M02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUF3MY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:24:26 -0400
Received: from aun.it.uu.se ([130.238.12.36]:62113 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266658AbUF3MXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:23:31 -0400
Date: Wed, 30 Jun 2004 14:23:14 +0200 (MEST)
Message-Id: <200406301223.i5UCNE0S014345@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, hamish@travellingkiwi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm4 compile buglet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 22:19:12 +0100, Hamie <hamish@travellingkiwi.com> wrote:
>drivers/built-in.o(.init.text+0x90ed): In function `do_wrlvtpc':
>: undefined reference to `apic_write'

Disable CONFIG_PERFCTR_INIT_TESTS or apply part 1/6
of the perfctr updates I just posted.
