Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbULMNsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbULMNsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbULMNsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:48:22 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:55529 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S262265AbULMNsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:48:19 -0500
Date: Mon, 13 Dec 2004 07:48:14 -0600
From: John Lash <jlash@speakeasy.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sata_sil.c: blacklist seagate ST380013AS
Message-ID: <20041213074814.130ef57f@homer.sarvega.com>
In-Reply-To: <20041202100304.4e8a9145@homer.sarvega.com>
References: <20041202100304.4e8a9145@homer.sarvega.com>
X-Mailer: Sylpheed-Claws 0.9.13cvs9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 10:03:04 -0600
John Lash <jkl@sarvega.com> wrote:

> Jeff,
> 
> here's a patch to add seagate ST380013AS to the sata_sil.c blacklist. and a
> pointer to the relevant thread on lkml.
> 

For what it's worth, I built an x86_64 kernel (2.6.9 and 2.6.10-rc3) for this
system and booted it. I didn't apply the blacklist patch yet. The system booted
fine, no complaints in the boot messages

Performance is good and the drive appears quite stable so far. I'm going to beat
on it a bit more over the next couple of days. If there is a particular test
that would be of interest, please let me know. I'm planning to do large reads
and writes with dd and a couple of runs with bonnie.

This might explain why some people are running Seagate drives with sata_sil with
no apparent problems.

--john
