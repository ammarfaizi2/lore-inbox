Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUH3OKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUH3OKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUH3OKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:10:16 -0400
Received: from the-village.bc.nu ([81.2.110.252]:43649 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266749AbUH3OKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:10:06 -0400
Subject: Re: K3b and 2.6.9?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Fairchild <tim@bcs4me.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408301047.06780.tim@bcs4me.com>
References: <200408301047.06780.tim@bcs4me.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093871277.30082.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 Aug 2004 14:07:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-30 at 01:47, Tim Fairchild wrote:
> Am I right in assuming that this is the way things will be done in the kernel 
> from now on and that we will need new versions of k3b/cdrecord to run with 
> these newer kernels? 

Folks are working on getting the verify_command list refined, or you 
can run the burner part of cd-burners setuid (as cdrecord supports -
although get the newest one since there was a security hole fixed a few
days ago in both cdrecord and star).

> Without knowing a better way, I am currently using the same sort of quick 
> patch as 2.6.8.1 to use k3b on 2.6.9-rc1-bk5 ie:

Providing you don't mind any of your users erasing your drive firmware
and turning the drive into a brick its fine. 

