Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTDPH4s (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 03:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTDPH4r 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 03:56:47 -0400
Received: from [12.47.58.203] ([12.47.58.203]:26843 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264256AbTDPH4r (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 03:56:47 -0400
Date: Wed, 16 Apr 2003 01:08:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server
 terminates
Message-Id: <20030416010854.55d02464.akpm@digeo.com>
In-Reply-To: <20030416075856.GC12031@suse.de>
References: <20030415133608.A1447@cuculus.switch.gts.cz>
	<20030415125507.GA29143@iucha.net>
	<3E9C03DD.3040200@oracle.com>
	<20030415164435.GA6389@rivenstone.net>
	<20030415182057.GC29143@iucha.net>
	<20030415154355.08ef6672.akpm@digeo.com>
	<20030416004556.GD29143@iucha.net>
	<20030416075856.GC12031@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2003 08:08:33.0008 (UTC) FILETIME=[5F750F00:01C303EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Tue, Apr 15, 2003 at 07:45:56PM -0500, Florin Iucha wrote:
> 
>  > > Has anyone tried disabling kernel AGP support and retesting?
>  > Now that you suggested it, I disabled kernel AGP support and 4.3.0
>  > (Daniel Stone Debian packages) works fine so far.
> 
> Thing is, if this runs rock solid now, it's not necessarily indicative
> of a bug in agpgart, it could equally be a bug in the DRM.
> This disables a whole bunch of code, it's practically a completely
> different application wrt 3d now.

Would disabling DRM, and enabling AGP be interesting?
