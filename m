Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSKCQ2l>; Sun, 3 Nov 2002 11:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbSKCQ2l>; Sun, 3 Nov 2002 11:28:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53957 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262100AbSKCQ2k>;
	Sun, 3 Nov 2002 11:28:40 -0500
Date: Sun, 3 Nov 2002 17:34:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Working ide-cd burn/rip, 2.5.44
Message-ID: <20021103163452.GA11068@suse.de>
References: <20021102184357.7091fd4d.arashi@arashi.yi.org> <20021103094229.GJ3612@suse.de> <20021103102902.77ae876b.arashi@arashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103102902.77ae876b.arashi@arashi.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Matt Reppert wrote:
> 3-arashi:~$ /opt/schily/bin/cdrecord dev=ATAPI:0,0,0 -checkdrive

use open by device name, ie dev=/dev/hdX

-- 
Jens Axboe

