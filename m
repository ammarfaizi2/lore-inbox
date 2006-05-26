Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWEZEaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWEZEaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWEZEaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:30:08 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:59858 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030341AbWEZEaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:30:06 -0400
Date: Fri, 26 May 2006 00:27:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [USB disks] FAT: invalid media value (0x01)
To: Pawel Sikora <pluto@agmk.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200605260029_MC3-1-C0CF-C67B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200605252310.00568.pluto@agmk.net>

(Sorry if I got your name wrong, the last letter came through as '?'.)

On Thu, 25 May 2006 23:10:00 +0200, Pawe? Sikora wrote:

> sdc: assuming drive cache: write through
>  sdc: sdc1
> sd 11:0:0:0: Attached scsi removable disk sdc
> usb-storage: device scan complete
> FAT: invalid media value (0x01)
> VFS: Can't find a valid FAT filesystem on dev sdc.
                                                ^^^

Shouldn't it be looking on sdc1 for the filesystem?

This could be some kind of hal/udev screwup.


-- 
Chuck
