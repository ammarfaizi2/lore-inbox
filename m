Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262367AbTCRNCK>; Tue, 18 Mar 2003 08:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbTCRNCK>; Tue, 18 Mar 2003 08:02:10 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:39951 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262367AbTCRNCK>; Tue, 18 Mar 2003 08:02:10 -0500
Message-ID: <3E771BE0.3000308@aitel.hist.no>
Date: Tue, 18 Mar 2003 14:15:12 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm1
References: <20030318031104.13fb34cc.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.65-mm1 seems to work fine on my up office machine.

Using devfs is no problem with debian unstable/testing.
No config files needed to be changed compared to "normal" devfs.
Three files needed changing compared to plain old  non-devfs:
/etc/fstab:   use /dev/discs/disc0/partX instead /dev/hdaX
/etc/gpm:     use mouse device /dev/input/mouse0 instead of /dev/psaux
/etc/inittab: Specify vc/X instead of ttyX for getty. X came up even
without this.

Helge Hafting



