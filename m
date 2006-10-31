Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423847AbWJaW4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423847AbWJaW4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423842AbWJaW4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:56:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423792AbWJaW4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:56:15 -0500
Date: Tue, 31 Oct 2006 14:55:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Peer Chen" <pchen@nvidia.com>
Cc: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] SCSI: Add nvidia AHCI controllers of MCP67 support to
 ahci.c
Message-Id: <20061031145514.8f19e2ad.akpm@osdl.org>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42D7F3@hkemmail01.nvidia.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0C42D7F3@hkemmail01.nvidia.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 19:06:58 +0800
"Peer Chen" <pchen@nvidia.com> wrote:

> Resend the patch.

This patch is still wordwrapped, is against a file which doesn't exist any more
(it moved into drivers/ata) and is wrong (ahci.c now uses helper macros in
these tables).

So please

- read http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt really
  carefully.  All of it.

- Download the most recent kernel from
  ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/ and regenerate and
  retest the patches.

- Send some test patches to yourself or to a colleague, make sure that
  they reach the other end in an applyable state.

then resend all of your patches: IDE, ahci, sata and hda_intel.

Thanks.
