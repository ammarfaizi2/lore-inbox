Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbTEFQLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTEFQLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:11:08 -0400
Received: from mail1.ewetel.de ([212.6.122.14]:13231 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263911AbTEFQK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:10:56 -0400
Date: Tue, 6 May 2003 18:23:21 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030506154323.GE905@suse.de>
Message-ID: <Pine.LNX.4.44.0305061822560.1310-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jens Axboe wrote:

> You also need to fix this in ide-cd:
> 
> 	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
> 		set_disk_ro(drive->disk, 0);

Ah, yes. I saw that line, but didn't pay attention.

-- 
Ciao,
Pascal

