Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWE3Jis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWE3Jis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWE3Jis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:38:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932215AbWE3Jis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:38:48 -0400
Date: Tue, 30 May 2006 02:42:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael McConnell <soruk@eridani.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.16.18: PPA driver oopses with large memory model
Message-Id: <20060530024239.843514d4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0605300828050.2126-100000@zeskia.int.eridani.co.uk>
References: <Pine.LNX.4.44.0605300828050.2126-100000@zeskia.int.eridani.co.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 08:32:18 +0100 (BST)
Michael McConnell <soruk@eridani.co.uk> wrote:

> Anyhow. Since upgrading the RAM in my machine to require CONFIG_HIMEM4G 
> (using CONFIG_VMSPLIT_3G) the PPA driver oopses with the following oops when 
> trying to write a file to the disc. 

Please test 2.6.17-rc5-mm1, or 2.6.17-rc5 plus
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/broken-out/git-scsi-rc-fixes.patch,
thanks.
