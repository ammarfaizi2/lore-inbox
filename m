Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbTCWAdI>; Sat, 22 Mar 2003 19:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCWAdI>; Sat, 22 Mar 2003 19:33:08 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:5154 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261459AbTCWAdH>; Sat, 22 Mar 2003 19:33:07 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303230044.h2N0i9r32560@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.65-ac3
To: jgarzik@pobox.com (Jeff Garzik)
Date: Sat, 22 Mar 2003 19:44:09 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3E7CF48F.9070204@pobox.com> from "Jeff Garzik" at Mar 22, 2003 06:41:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once your tty and ide bits are merged, what's left on the plate (in your 
> opinion) before 2.6.0-test1?

32bit dev_t is a showstopper

then 

Debugging, debugging, and more debugging
Driver porting
Driver resyncs with 2.4
Finding the remaining scsi bugs
A ton more IDE work before I am happy
Fixing the pci api hotplug races
DRM 4.3 cleaned up and working


I think the dev_t one is the only stopper now before we go into
stop futzing with core code and fix bugs mode
