Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWAAWhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWAAWhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 17:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAAWhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 17:37:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:7131 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932284AbWAAWhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 17:37:09 -0500
Subject: Re: PROBLEM: Linux ATAPI CDROM ->FIX: SAMSUNG CD-ROM SC-140
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: gcoady@gmail.com
Cc: "Steven J. Hathaway" <shathawa@e-z.net>, andre@linux-ide.org,
       axobe@suse.de, linux-kernel@vger.kernel.org, andre@linuxdiskcert.org
In-Reply-To: <8mkgr1p00i4c6jf3ej9t77rbd3kpo7s001@4ax.com>
References: <43B6146C.60E044FF@e-z.net>
	 <1136030788.28365.49.camel@localhost.localdomain>
	 <8mkgr1p00i4c6jf3ej9t77rbd3kpo7s001@4ax.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 01 Jan 2006 22:34:55 +0000
Message-Id: <1136154895.23870.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-02 at 09:23 +1100, Grant Coady wrote:
> Jan  2 09:02:33 niner kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Jan  2 09:02:33 niner kernel: hdc: drive_cmd: error=0x04Aborted Command
> Jan  2 09:02:52 niner kernel: hdc: CHECK for good STATUS
> Jan  2 09:03:26 niner kernel: hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }

Thats showing a media error. Shouldn't have caused a hang however.

