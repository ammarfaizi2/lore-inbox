Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUHOVb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUHOVb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHOVb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:31:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8330 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266901AbUHOVb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:31:28 -0400
Date: Sun, 15 Aug 2004 16:57:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tetsuo Handa <a5497108@anet.ne.jp>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: TG3 doesn't work in kernel 2.4.27
Message-ID: <20040815195758.GE9500@logos.cnet>
References: <200408150152.EAC63479.8815296B@anet.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408150152.EAC63479.8815296B@anet.ne.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 01:53:49AM +0900, Tetsuo Handa wrote:
> Hello,
> 
> I'm using tg3.o with DHCP and PXE boot environment
> and I updated from 2.4.26 to 2.4.27,
> but tg3.o became not working with IBM BladeCenter.
> 
> I think tg3.o in 2.4.27 is generating something broken arp.
> When I run 'arp' in the DHCP server (who doesn't use tg3.o),
> the entry with <incomplete> status appears.
> The IP address which has the <incomplete> status is
> the DHCP client's (who is using tg3.o in 2.4.27).
> 
> The workaround I took is to replace tg3.h and tg3.c
> in 2.4.27 with the files in 2.4.26, and it seems working fine.

David Miller is the tg3 maintainer, he will help you.
