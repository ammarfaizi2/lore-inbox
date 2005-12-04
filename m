Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVLDTtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVLDTtq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVLDTtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:49:45 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:51471 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932319AbVLDTtp
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 14:49:45 -0500
Date: Sun, 4 Dec 2005 15:41:32 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Norbert van Nobelen <norbert-kernel@hipersonik.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: UML with 2.6.14-3 kernel
Message-ID: <20051204204132.GA29782@ccure.user-mode-linux.org>
References: <200512042029.32038.norbert-kernel@hipersonik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512042029.32038.norbert-kernel@hipersonik.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 08:29:31PM +0100, Norbert van Nobelen wrote:
> VFS: Cannot open root device "/tmp/root_fs" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
You don't have the UBD driver configured in?

Start over with a defconfig - that will give you a sane configuration.

				Jeff
