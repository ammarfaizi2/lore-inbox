Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUIQPec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUIQPec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIQPeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:34:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:20938 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268877AbUIQPSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:18:30 -0400
Subject: Re: The ultimate TOE design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Mudama <edmudama@gmail.com>
Cc: David Stevens <dlstevens@us.ibm.com>, Netdev <netdev@oss.sgi.com>,
       leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <311601c90409162346184649eb@mail.gmail.com>
References: <4148991B.9050200@pobox.com>
	 <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
	 <311601c90409162346184649eb@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095430526.26088.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 15:15:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-17 at 07:46, Eric Mudama wrote:
> On Wed, 15 Sep 2004 14:11:04 -0600, David Stevens <dlstevens@us.ibm.com> wrote:
> > Why don't we off-load filesystems to disks instead?
> 
> Disks have had file systems on them since close to the beginning...

This is essentially the path Lustre is taking. Although it seems you
don't want to have a "full" file system on the disk since you lose to
much flexibility, instead you want the ability to allocate by handle
giving hints about locality and use.

People have also tried full file system offload - intel for example
prototyped an I2O file system class, and adaptec clearly were trying
this out on aacraid development from looking at the public headers.

Alan

