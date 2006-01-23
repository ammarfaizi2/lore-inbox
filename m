Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWAWNwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWAWNwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWAWNwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:52:33 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:33661 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751416AbWAWNwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:52:32 -0500
Date: Mon, 23 Jan 2006 15:55:51 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Andi Kleen <ak@suse.de>, Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH] x86_64: Remove useless KDB vector
Message-ID: <20060123135551.GA14271@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was set as an NMI, but the NMI bit always forces an interrupt
> to end up at vector 2. So it was never used. Remove.

So with this function removed, what is the proper fix for using 
the kdb x86_64 patch (forward-ported from 2.6.14) on 2.6.16-rc1?
Can I expect it to work properly if I just remove the function 
call?

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
