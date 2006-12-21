Return-Path: <linux-kernel-owner+w=401wt.eu-S1422870AbWLUIzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWLUIzy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWLUIzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:55:54 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:2510 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422870AbWLUIzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:55:53 -0500
Date: Thu, 21 Dec 2006 09:55:54 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-Id: <20061221095554.2f06767e.khali@linux-fr.org>
In-Reply-To: <20061221044125.GA5921@in.ibm.com>
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<20061221044125.GA5921@in.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Thu, 21 Dec 2006 10:11:26 +0530, Vivek Goyal wrote:
> What's the value of CONFIG_PHYSICAL_ALIGN? How much RAM is present in your
> system? Though very unlikely, just trying to find that we are not running
> short of RAM while trying to align the kernel to a large value.

CONFIG_PHYSICAL_ALIGN=0x100000
(which is the default as far as I know)
The system has 512 MB RAM.

> Can you please provide your config file. Is it possible to provide your
> bzImage? Can you upload it somewhere? Will try to boot it on my box just
> to find out if it could be in some way related to compiler/linker.

http://jdelvare.pck.nerim.net/linux/relocatable-bug/

gcc version is 3.2.3
ld version is 2.14.90.0.6

Thanks,
-- 
Jean Delvare
