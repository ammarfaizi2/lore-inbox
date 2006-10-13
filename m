Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWJMOOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWJMOOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWJMOOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:14:15 -0400
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:53137 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750845AbWJMOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:14:14 -0400
Date: Fri, 13 Oct 2006 16:14:21 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Brice Figureau <brice+lklm@daysofwonder.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sluggish system while copying large files.
Message-ID: <20061013161421.7ecba339@localhost>
In-Reply-To: <1160747774.7929.53.camel@localhost.localdomain>
References: <1160747774.7929.53.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 15:56:14 +0200
Brice Figureau <brice+lklm@daysofwonder.com> wrote:

> I have a brand new Dell 2850 biXeon x86_64 with a Perc4e/Di (megaraid)
> RAID card with two hardware RAID1 volumes (sda and sdb, ext3 on top of
> LVM2, io scheduler deadline).
> 
> This machine runs 2.6.18 and is used as a mysql server.
> 
> Whenever I cp large files (for instance during backup) from one volume
> to the other, the system becomes really sluggish. 

I used to have this problem and it seems that 2.6.19-rc1 and later
kernels are better (at least for me).

-- 
	Paolo Ornati
	Linux 2.6.19-rc1-g9eb20074 on x86_64
