Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbUK2Mui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUK2Mui (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUK2Msz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:48:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:52377 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261694AbUK2Mso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:48:44 -0500
Subject: Re: Question about /dev/mem and /dev/kmem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Nelson <james4765@verizon.net>
Cc: Wichert Akkerman <wichert@wiggy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41AAFE4E.7010308@verizon.net>
References: <41AA9E26.4070105@verizon.net>
	 <20041129093937.GN31995@wiggy.net>  <41AAFE4E.7010308@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101728717.20220.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 11:45:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 10:47, Jim Nelson wrote:
> And what stops an attacker who's already gained root from doing a "cat "0" > 
> /proc/sys/kernel/cap-bound" ?

If they already had root you've already lost.

An SELinux policy would probably be a lot more useful because you also
want to block ioperm/iopl

