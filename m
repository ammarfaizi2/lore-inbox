Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbTDRUeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 16:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTDRUeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 16:34:13 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57276 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263233AbTDRUeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 16:34:12 -0400
Date: Fri, 18 Apr 2003 16:46:05 -0400
From: Bill Nottingham <notting@redhat.com>
To: Dave Mehler <dmehler26@woh.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mkinitrd
Message-ID: <20030418164605.B2090@devserv.devel.redhat.com>
Mail-Followup-To: Dave Mehler <dmehler26@woh.rr.com>,
	linux-kernel@vger.kernel.org
References: <000501c305cb$a7a8e6b0$0200a8c0@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000501c305cb$a7a8e6b0$0200a8c0@satellite>; from dmehler26@woh.rr.com on Fri, Apr 18, 2003 at 12:57:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Mehler (dmehler26@woh.rr.com) said: 
>     Same deal as before, on my rh9 box i have mkinitrd version 3.4.42-1
>     Is this sufficient for running a 2.5 kernel? I heard there was some
> update to mkinitrd i might have to get, which might explain why the system
> is hanging after the initrd image, but have not been able to find it.

It needs to be patched to find modules with the new suffix... the simplest
way is to probably change the reference for $modName.o.gz to $modName.ko.

Bill
