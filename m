Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbREVNc3>; Tue, 22 May 2001 09:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbREVNcT>; Tue, 22 May 2001 09:32:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21775 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261683AbREVNcI>; Tue, 22 May 2001 09:32:08 -0400
Subject: Re: Fix for an SMP locking bug in NFS code
To: matthewc@cse.unsw.edu.au (Matt Chapman)
Date: Tue, 22 May 2001 14:28:47 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        trond.myklebust@fys.uio.no (Trond Myklebust),
        linux-kernel@vger.kernel.org (Linux Kernel),
        linux-fsdevel@vger.kernel.org (Linux FS-Devel)
In-Reply-To: <20010522231139.A515@cse.unsw.edu.au> from "Matt Chapman" at May 22, 2001 11:11:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152CDP-0001rY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've already run this by Trond so I'm sending this patch without
> further ado.  It adds a lock_kernel around a call into NLM code,
> and removes an extraneous (really) lock_kernel in sys_fcntl64.

matthew@wil.cx is the locking code maintainer if he's not already seen this

