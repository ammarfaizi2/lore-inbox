Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUHOXg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUHOXg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbUHOXgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:36:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25741 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267249AbUHOXgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:36:45 -0400
Message-ID: <411FF37E.7070001@pobox.com>
Date: Sun, 15 Aug 2004 19:36:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca>
In-Reply-To: <411FF170.9070700@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> hdparm works for some SCSI devices already, and support for
> more is already on the way.  I imagine I can have it handle
> whatever new ioctls() are being provided from libata as well.
> 
> Care to point me at them?


No new ioctls :)  Say no to ioctls :)

libata _may_ support HDIO_DRIVE_CMD, but more likely will support 
http://www.t10.org/ftp/t10/document.04/04-262r1.pdf

and simply use existing interfaces.

	Jeff


