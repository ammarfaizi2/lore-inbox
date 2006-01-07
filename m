Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWAGXuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWAGXuL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWAGXuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:50:10 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:20427 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1161071AbWAGXuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:50:09 -0500
Date: Sat, 7 Jan 2006 16:50:09 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/qla2xxx/Kconfig: two fixes
Message-ID: <20060107235009.GH19769@parisc-linux.org>
References: <20060106163401.GP12131@stusta.de> <20060106211241.GG13844@andrew-vasquezs-powerbook-g4-15.local> <20060106230935.GC3774@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106230935.GC3774@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 12:09:35AM +0100, Adrian Bunk wrote:
> Due to the change of SCSI_QLA2XXX to a user-visible option that builds 
> the driver, this means that suddenly after upgrading the kernel and 
> running "make oldconfig" a SCSI driver gets built the user never 
> selected.
> 
> Do you have any suggestions for a new name?
> We could e.g. name it SCSI_QLAXXXX since the driver also supports 
> 6312/6322, or name it simply SCSI_QLA.

SCSI_QLOGIC_FC?  Or does this driver handle SAS too?
