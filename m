Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUK3VXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUK3VXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbUK3VXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:23:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:1951 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262322AbUK3VXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:23:48 -0500
Subject: Re: user- vs kernel-level resource sandbox for Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: grendel@caudium.net
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Jeff Dike <jdike@addtoit.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130204708.GB14080@beowulf.thanes.org>
References: <20041129101919.GB9419@beowulf.thanes.org>
	 <200411292000.iATK0qOF004026@ccure.user-mode-linux.org>
	 <16811.40687.892939.304185@wombat.chubb.wattle.id.au>
	 <20041130023947.GI5378@beowulf.thanes.org>
	 <1101840505.25628.105.camel@localhost.localdomain>
	 <20041130204708.GB14080@beowulf.thanes.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101846018.25628.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 20:20:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 20:47, Marek Habersack wrote:
> That's my current impression. I also considered writing a simple kernel
> module to intercept sys_brk, but that seemed to be a bit clumsy. We have

You have to consider kernel side resources too - page tables, memory
maps
and the like which jails don't really fix. 

