Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSJZNvk>; Sat, 26 Oct 2002 09:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262145AbSJZNvk>; Sat, 26 Oct 2002 09:51:40 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8249 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262137AbSJZNvi>; Sat, 26 Oct 2002 09:51:38 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210261357.g9QDvgl13774@devserv.devel.redhat.com>
Subject: Re: [PATCH] Double x86 initialise fix.
To: davej@codemonkey.org.uk (Dave Jones)
Date: Sat, 26 Oct 2002 09:57:42 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
       alan@redhat.com
In-Reply-To: <20021026134947.GA31349@suse.de> from "Dave Jones" at Oct 26, 2002 02:49:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Isn't this always the case on x86 ?
> /me waits to hear gory details of some IBM monster.

It isnt. The boot CPU may be any number. In addition you can strap dual
pentium boxes to arbitrate for who is boot cpu (this is used for fault
tolerance).

