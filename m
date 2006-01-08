Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWAHNx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWAHNx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWAHNx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:53:27 -0500
Received: from xenotime.net ([66.160.160.81]:61076 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161062AbWAHNx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:53:27 -0500
Date: Sun, 8 Jan 2006 05:53:22 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: vherva@vianova.fi
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-Id: <20060108055322.18d4236e.rdunlap@xenotime.net>
In-Reply-To: <20060108133822.GD31624@vianova.fi>
References: <20060105045212.GA15789@redhat.com>
	<Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
	<20060105103339.GG20809@redhat.com>
	<20060108133822.GD31624@vianova.fi>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 15:38:22 +0200 Ville Herva wrote:

> On Thu, Jan 05, 2006 at 05:33:39AM -0500, you [Dave Jones] wrote:
> > 
> > If I had any faith in the sturdyness of the floppy driver, I'd
> > recommend someone looked into a 'dump oops to floppy' patch, but
> > it too relies on a large part of the system being in a sane
> > enough state to write blocks out to disk.
> 
> I believe kmsgdump (http://www.xenotime.net/linux/kmsgdump/) uses its own
> minimal 16-bit floppy driver to save the oops dump. 

It just switches to real mode and uses BIOS calls.

> Kmsgdump has been around for ages and still works with 2.6.x. I almost
> always use it (all of my boxes still have floppy drives.)


---
~Randy
