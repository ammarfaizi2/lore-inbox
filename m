Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270453AbUJUCMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbUJUCMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270722AbUJUCDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:03:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30438 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270747AbUJUCCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:02:48 -0400
Date: Wed, 20 Oct 2004 19:02:07 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Georg Schild <dangertools@gmx.net>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Weird behaviour of usb printer (drivers/usb/class/usblp.c:
 usblp0:	error -110 reading printer status)
Message-ID: <20041020190207.27b93ba0@lembas.zaitcev.lan>
In-Reply-To: <mailman.1098049140.31627.linux-kernel2news@redhat.com>
References: <mailman.1098049140.31627.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 23:34:12 +0200, Georg Schild <dangertools@gmx.net> wrote:

> drivers/usb/class/usblp.c: usblp0: error -110 reading printer status

A known problem. Also very rare, unfortunately.

> I have tried several kernelversions, some with included patchset from
> gentoo and some vanilla kernels.

You are making a usual mistake here. It is essential for you not to
cover the widest possible field at this point, but to name AT LEAST ONE
version which is proven to have this defect. Please do so.

Also, please send your /proc/bus/usb/devices.

-- Pete
