Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTIYBAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 21:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTIYBAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 21:00:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261623AbTIYBAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 21:00:54 -0400
Date: Thu, 25 Sep 2003 02:00:52 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Douglas Gilbert <dougg@torque.net>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
Message-ID: <20030925010052.GD7665@parcelfarce.linux.theplanet.co.uk>
References: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl> <3F723A04.2000609@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F723A04.2000609@torque.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 10:42:44AM +1000, Douglas Gilbert wrote:
> I have a USB 500 MB USB key that confuses linux (both 2.4 and
> 2.6) since it has no partition table. It shows up on my laptop as:

Confuses it in which sense?
 
> $ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: Prolific Model: USBFlashDisk     Rev: 1.00
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> 
> I can mount it with:
> $ mount /dev/sda /mnt/extra

So it works fine.  what's the problem?
