Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTATTRm>; Mon, 20 Jan 2003 14:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbTATTRl>; Mon, 20 Jan 2003 14:17:41 -0500
Received: from jstevenson.plus.com ([212.159.71.212]:29897 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S266686AbTATTRl>;
	Mon, 20 Jan 2003 14:17:41 -0500
Subject: Re: 2.4.20 and ext3 error.
From: James Stevenson <james@stev.org>
To: Andrey Nekrasov <andy@spylog.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030120110611.GA4862@an.local>
References: <20030120110611.GA4862@an.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Jan 2003 19:27:32 +0000
Message-Id: <1043090853.1753.40.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 11:06, Andrey Nekrasov wrote:
> Hello.
> 
> kernel 2.4.20 write (dmesg):
> 
> ...
> EXT3-fs warning: mounting fs with errors, running e2fsck is recommended

this might give a little clue. e2fsck has found a system with errors and
marked it has errrors


yup this looks like an error to me.
> EXT3-fs error (device ide2(33,1)): ext3_readdir: bad entry in directory #2853202:
> rec_len % 4 != 0 - offset=0, inode=1754302946, rec_len=34858, name_len=134
> Aborting journal on device ide2(33,1).
> Remounting filesystem read-only

> 
> why?



