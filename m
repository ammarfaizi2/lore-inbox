Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVGDQXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVGDQXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVGDQXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:23:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:46732
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261165AbVGDQWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:22:53 -0400
Subject: Re: patch to create sysfs char device nodes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: coywolf@lovecn.org
Cc: Paolo Galtieri <pgaltieri@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-mtd@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <2cd57c90050704091420198987@mail.gmail.com>
References: <1118327333.2401.42.camel@playin.mvista.com>
	 <2cd57c90050704091420198987@mail.gmail.com>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 04 Jul 2005 18:25:41 +0200
Message-Id: <1120494341.18862.100.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 00:14 +0800, Coywolf Qi Hunt wrote:
> On 6/9/05, Paolo Galtieri <pgaltieri@mvista.com> wrote:
> > Hi,
> >   with DEVFS going away I discovered that no character device nodes are
> > created if a flash device is present which contains filesystems. The
> > mtd-utils package requires the existence of character device nodes for
> > performing erase, lock and unlock functions.  The problem is that the
> > flash device driver has not been modified to use sysfs instead of devfs.
> > 
> > I have attached a patch to mtdchar.c which uses the sysfs interface to
> > create the appropriate nodes.  Please let me know if you have comments.
> 
> I encountered the same problem days ago. Thanks for the patch. A patch
> based on yours will be sent in the next mail.

A reworked patch is in the MTD CVS and in the mtd-git tree already. No
need to send something

tglx


