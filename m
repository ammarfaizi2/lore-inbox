Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVCYSmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVCYSmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVCYSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:42:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:21988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261745AbVCYSkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:40:45 -0500
Date: Fri, 25 Mar 2005 10:40:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-Id: <20050325104032.786c4257.akpm@osdl.org>
In-Reply-To: <a44ae5cd05032504521e0db1d4@mail.gmail.com>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<a44ae5cd05032420122cd610bd@mail.gmail.com>
	<20050324202215.663bd8a9.akpm@osdl.org>
	<20050325073846.A18596@flint.arm.linux.org.uk>
	<20050324234544.135a1eb2.akpm@osdl.org>
	<20050325075032.B18596@flint.arm.linux.org.uk>
	<20050325081359.C18596@flint.arm.linux.org.uk>
	<a44ae5cd05032504521e0db1d4@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> Ahem.  In this case, I think it was operator error.  I reproduced the
> problem and have included the entire output of ksymoops below.

Please don't use ksymoops.  2.6 kernels decode oopses internally and
ksymoops actually removes a little info.

> Andrew, this command causes the Oops for me:
> 
> root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls
> ./  ../  device@
> root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls -l
> Segmentation fault

What device is that, and which driver is handling it?
