Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUEVPYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUEVPYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUEVPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:23:59 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:44999 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S261582AbUEVPXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:23:52 -0400
Message-ID: <40AF7080.50607@stanchina.net>
Date: Sat, 22 May 2004 17:23:44 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: system <system@eluminoustechnologies.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hda Kernel error!!!
References: <200405221257.28570.system@eluminoustechnologies.com>
In-Reply-To: <200405221257.28570.system@eluminoustechnologies.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

system wrote:
>    hda: drive_cmd: error=0x04 { DriveStat...:  1Time(s)
>    hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }...:  1Time(s)
> 
> What is this error?

You need to tell us:
- kernel version
- make and model of the hard disk
- make and model of the controller (or chipset)

If you are using kernel 2.6.6 and a Maxtor disk, then it's a known 
problem. Search the LKML archives and look at the post-2.6.6 changes to 
drivers/ide/ide-disk.c.

-- 
Ciao, Flavio

