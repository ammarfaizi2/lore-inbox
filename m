Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWHXQyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWHXQyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWHXQyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:54:36 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:53678 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1030387AbWHXQyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:54:36 -0400
Date: Thu, 24 Aug 2006 17:54:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Rodrick <daniel.rodrick@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>,
       linux-newbie@vget.kernel.org, satinder.jeet@gmail.com
Subject: Re: Generic Disk Driver in Linux
Message-ID: <20060824165401.GB19881@linux-mips.org>
References: <292693080608240547w394bacc4l2410b6eba98d950b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292693080608240547w394bacc4l2410b6eba98d950b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 06:17:59PM +0530, Daniel Rodrick wrote:

> I was curious that can we develop a generic disk driver that could
> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
> 
> I thought we could use the BIOS interrupt 13H for this purpose, but
> ran into a LOT of real mode / protected mode issues.

A BIOS only contains a better than nothing quality driver, take the VESA
VLB driver as an example.  And lacks portability, upgrading is a pain.

  Ralf
