Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUFUH6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUFUH6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266148AbUFUH6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:58:38 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:64389 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266141AbUFUH6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:58:37 -0400
Date: Mon, 21 Jun 2004 16:59:52 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 1/4]Diskdump Update
In-reply-to: <1086954645.2731.23.camel@laptop.fenrus.com>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Message-id: <DBC45765BB709Eindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1086954645.2731.23.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now I am fixing diskdump according to comments by you and Christoph.

On Fri, 11 Jun 2004 13:50:45 +0200, Arjan van de Ven wrote:

>> +#ifdef CONFIG_PROC_FS
>> +static int proc_ioctl(struct inode *inode, struct file *file, unsigned 
>> int cmd, unsigned long param)
>
>
>ehhh this looks evil

Do you mean I should use not ioctl but the following style?

echo "add /dev/hda1" > /proc/diskdump
echo "delete /dev/hda1" > /proc/diskdump


Best Regards,
Takao Indoh
