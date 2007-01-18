Return-Path: <linux-kernel-owner+w=401wt.eu-S1752043AbXARQCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXARQCq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXARQCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:02:46 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:46765 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbXARQCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:02:45 -0500
Date: Thu, 18 Jan 2007 16:03:38 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, akpm@osdl.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
Message-ID: <20070118160338.GA6343@linux-mips.org>
References: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 12:23:46AM +0900, Atsushi Nemoto wrote:

> CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> might result in allocation failure for the reserving itself on some
> platforms (for example typical 32bit MIPS).  Make it (and
> CARDBUS_IO_SIZE too) customizable for such platforms.

Patch looks technically ok to me, so feel free to add my Acked-by: line.

The grief I have with this sort of patch is that this kind of detailed
technical knowledge should not be required by a mortal configuring the
Linux kernel.

  Ralf
