Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281103AbRKOVzt>; Thu, 15 Nov 2001 16:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281096AbRKOVzk>; Thu, 15 Nov 2001 16:55:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281091AbRKOVzf>; Thu, 15 Nov 2001 16:55:35 -0500
Subject: Re: generic_file_llseek() broken?
To: adilger@turbolabs.com (Andreas Dilger)
Date: Thu, 15 Nov 2001 22:02:45 +0000 (GMT)
Cc: helgehaf@idb.hist.no (Helge Hafting), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <20011115140917.Q5739@lynx.no> from "Andreas Dilger" at Nov 15, 2001 02:09:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164Uas-0001pl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe also sys_truncate should disallow truncating to a size larger
> than s_maxbytes.  Al? For now, returning EOVERFLOW from do_truncate()
> when (length > inode->i_sb->s_maxbytes) should be OK.

It should do in the last patches I sent Linus.
