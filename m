Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWAJBqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWAJBqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWAJBqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:46:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:16050 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750871AbWAJBqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:46:36 -0500
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060109164410.3304a0f6.akpm@osdl.org>
References: <20060109203711.GA25023@kroah.com>
	 <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
	 <20060109164410.3304a0f6.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Jan 2006 01:49:02 +0000
Message-Id: <1136857742.14532.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-09 at 16:44 -0800, Andrew Morton wrote:
> - Reuben Farrelly's oops in make_class_name().  Could be libata, or scsi
>   or driver core.

libata I think. I reproduced it on 2.6.14-mm2 by accident with a buggy
pata driver.


