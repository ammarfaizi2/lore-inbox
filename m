Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933358AbWKNJtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933358AbWKNJtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933359AbWKNJtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:49:52 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:30199 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S933358AbWKNJtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:49:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: suzuki <suzuki@linux.vnet.ibm.com>
Subject: Re: + fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch added to -mm tree
Date: Tue, 14 Nov 2006 10:49:35 +0100
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <200611132358.kADNwF0V012270@shell0.pdx.osdl.net> <200611140138.19111.arnd@arndb.de> <45591BD1.9070600@linux.vnet.ibm.com>
In-Reply-To: <45591BD1.9070600@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141049.36145.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 02:28, suzuki wrote:
> 
> I left it as such, inorder to avoid the future changes that may come in 
> the struct msgbuf -if at all-, which would make us to pass every single 
> field as a parameter to do_msgrcv/do_msgsnd.

struct msgbuf is part of the kernel ABI and will never change, so that's
no problem at all.

	Arnd <><
