Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUGVPyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUGVPyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUGVPyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:54:49 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:28382 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S265196AbUGVPys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:54:48 -0400
Message-ID: <1090511685.40ffe345f252b@imp6-q.free.fr>
Date: Thu, 22 Jul 2004 17:54:45 +0200
From: christophe.varoqui@free.fr
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Q] claimed block devices
References: <1090489874.40ff8e1226ad0@imp6-q.free.fr> <1090499383.17489.39.camel@shaggy.austin.ibm.com>
In-Reply-To: <1090499383.17489.39.camel@shaggy.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.4
X-Originating-IP: 171.16.4.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Dave Kleikamp <shaggy@austin.ibm.com>:

> On Thu, 2004-07-22 at 04:51, christophe.varoqui@free.fr wrote:
> > Hello,
> >
> > does somebody know how a userspace C-proggy can detect if a block device is
> > claimed  ? Creating a device map over such devices will fail, so better not
> to
> > try.
>
> I believe trying to open the device with O_EXCL will fail if the device
> is claimed.
>
> Shaggy
> --

if I read fs/block_dev.c correctly, O_EXCL will always fail on block device.
I would also like to use the lock owner information ... which seems even more
tricky.

regards,
cvaroqui
--
