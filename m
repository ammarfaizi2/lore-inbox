Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUDSINt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUDSINt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:13:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:35991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264298AbUDSINs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:13:48 -0400
Date: Mon, 19 Apr 2004 01:13:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on forcing cache data to write out
Message-Id: <20040419011329.0b07b0ad.akpm@osdl.org>
In-Reply-To: <20040419073507.8572.qmail@web90005.mail.scd.yahoo.com>
References: <20040419073507.8572.qmail@web90005.mail.scd.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab <phyprabab@yahoo.com> wrote:
>
> Sirs,
> 
> I am interested in understanding how tot tune the 2.6
> kernel such that I can get the WM to write out data
> that is held within the "cache".
> 
> My situtation is that I have a NFS file server that
> gets data in bursts.  The first couple of burst move
> quickly, but once the system memory becomes filled,
> mostly held in "cache", then my NFS performance drops.
>  The issue here is how to get the VM to write out the
> data held within the cache when times are slow (which
> amounts to 90% of the time)?  I have played a little
> bit with the /proc/sys/vm/dirty_ratio, etc with out
> much help.

Setting dirty_background_ratio lower might smooth things out.
