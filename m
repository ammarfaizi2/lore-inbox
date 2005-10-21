Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVJUSGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVJUSGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVJUSGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:06:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:39348 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965052AbVJUSGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:06:30 -0400
Subject: Re: Patch: ATI Xilleon port 10/11 Xilleon IDE controller support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ddaney@avtrex.com
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <17239.48184.340986.463557@dl2.hq2.avtrex.com>
References: <17239.48184.340986.463557@dl2.hq2.avtrex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 19:35:05 +0100
Message-Id: <1129919705.3542.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-10-20 at 08:48 -0700, David Daney wrote:

> +int xilleon_ide_proc;
> +
> +static struct pci_dev *bmide_dev;
> +
> +/* #define DEBUG 1 */
> +
> +#if defined(CONFIG_PROC_FS)
> +static u8 xilleon_proc = 0;

The proc interfaces have been dropped so this chunk can all go away

> +
> +/**
> + *	xilleon_ide_get_info		-	generate xilleon /proc file 
> + *	@buffer: buffer for data
> + *	@addr: set to start of data to use
> + *	@offset: current file offset
> + *	@count: size of read


