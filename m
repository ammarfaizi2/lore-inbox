Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbUKQWwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUKQWwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbUKQWwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:52:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262599AbUKQWtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:49:53 -0500
Date: Wed, 17 Nov 2004 14:53:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc2-mm1] OOPS on boot (hotplug related?)
Message-Id: <20041117145359.4f017ed1.akpm@osdl.org>
In-Reply-To: <419BBFD1.7060306@lanil.mine.nu>
References: <419BBFD1.7060306@lanil.mine.nu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Axelsson <smiler@lanil.mine.nu> wrote:
>
> I'm getting OOPSes on boot on my laptop. Output is copied by hand and Ive 
> only included the parts that I *think* are useful:
> 
> ...
> EIP is at get_nonexclusive_access+0x13/0x40

Yup, seems that reiser4 broke.  I've forwarded a copy of an earlier report
to reiserfs-dev@namesys.com.
