Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWJNQDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWJNQDO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 12:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWJNQDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 12:03:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:228 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422707AbWJNQDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 12:03:13 -0400
Subject: Re: [PATCH]: disassociate tty locking fixups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <4530FD0F.4050305@redhat.com>
References: <20061014112218.30218.93267.sendpatchset@prarit.boston.redhat.com>
	 <1160830509.5732.26.camel@localhost.localdomain>
	 <4530FD0F.4050305@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 17:29:19 +0100
Message-Id: <1160843359.5732.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-14 am 11:06 -0400, ysgrifennodd Prarit Bhargava:
> So the locking order is (for example):
> 
> mutex_lock(&tty_mutex);
> read_lock(&tasklist_lock);
> task_lock(current);
> 
> Correct?

Yes


Alan

