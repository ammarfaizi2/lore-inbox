Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQJ3Heo>; Mon, 30 Oct 2000 02:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129151AbQJ3Hed>; Mon, 30 Oct 2000 02:34:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19723 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129150AbQJ3HeW>; Mon, 30 Oct 2000 02:34:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: / on ramfs, possible?
Date: 29 Oct 2000 23:34:01 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tj899$dqg$1@cesium.transmeta.com>
In-Reply-To: <200010300727.IAA12250@hell.wii.ericsson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200010300727.IAA12250@hell.wii.ericsson.net>
By author:    Anders Eriksson <aer-list@mailandnews.com>
In newsgroup: linux.dev.kernel
> 
> I want my / to be a ramfs filesystem. I intend to populate it from an 
> initrd image, and then remount / as the ramfs filesystem. Is that at 
> all possible? The way I see it the kernel requires / on a device 
> (major,minor) or nfs.
> 
> Am I out of luck using ramfs as /? If it's easy to fix, how do I fix it?
> 

Use pivot_root instead of the initrd stuff in /proc/sys.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
