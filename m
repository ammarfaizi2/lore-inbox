Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTKRCyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 21:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTKRCyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 21:54:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62119 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262310AbTKRCyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 21:54:45 -0500
Date: Tue, 18 Nov 2003 02:54:40 +0000
From: Matthew Wilcox <willy@debian.org>
To: Amit Patel <patelamitv@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: scsi_report_lun_scan bug?
Message-ID: <20031118025440.GH30485@parcelfarce.linux.theplanet.co.uk>
References: <20031118024833.7619.qmail@web13006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118024833.7619.qmail@web13006.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 06:48:33PM -0800, Amit Patel wrote:
> [root@Host200-w2k root]# diff
> /cdrive/mm1/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
> /cdrive/mm3/linux-2.6.0-test9/drivers/scsi/scsi_scan.c
> 902c902
> <       char *data;
> ---
> >       unsigned char *data;

Hi Amit.  Can you send diffs in unified format in the future, ie diff -u
Thanks.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
