Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWEZGRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWEZGRt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 02:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWEZGRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 02:17:49 -0400
Received: from agmk.net ([217.73.31.34]:59908 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1030470AbWEZGRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 02:17:48 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [USB disks] FAT: invalid media value (0x01)
Date: Fri, 26 May 2006 08:17:33 +0200
User-Agent: KMail/1.9.1
References: <200605260029_MC3-1-C0CF-C67B@compuserve.com>
In-Reply-To: <200605260029_MC3-1-C0CF-C67B@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605260817.33382.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 06:27, Chuck Ebbert wrote:
> In-Reply-To: <200605252310.00568.pluto@agmk.net>
>
> (Sorry if I got your name wrong, the last letter came through as '?'.)
>
> On Thu, 25 May 2006 23:10:00 +0200, Pawe? Sikora wrote:
> > sdc: assuming drive cache: write through
> >  sdc: sdc1
> > sd 11:0:0:0: Attached scsi removable disk sdc
> > usb-storage: device scan complete
> > FAT: invalid media value (0x01)
> > VFS: Can't find a valid FAT filesystem on dev sdc.
>
>                                                 ^^^
>
> Shouldn't it be looking on sdc1 for the filesystem?
>
> This could be some kind of hal/udev screwup.

Ohhh, It was a typo in my /etc/fstab.
s:/dev/sdc:/dev/sdc1: and everything works fine.
Thanks :)
