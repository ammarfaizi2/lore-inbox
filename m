Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282364AbRKXFGj>; Sat, 24 Nov 2001 00:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282365AbRKXFG3>; Sat, 24 Nov 2001 00:06:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282364AbRKXFGO>; Sat, 24 Nov 2001 00:06:14 -0500
Message-ID: <3BFF2AAE.7000000@zytor.com>
Date: Fri, 23 Nov 2001 21:05:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no> <9tmr83$jo2$1@cesium.transmeta.com> <20011123212557.U1308@lynx.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> 
> Actually, unless users are actively trying to shoot themselves in the
> foot, none of this really matters.  However, now that ext3 is in the
> mainline, the number of users playing with guns has increased a large
> amount, it seems, by the number of such reports on ext3-users.
> 
> Because .journal is created as immutable, even if it was backed up and
> tried to be restored, it would be impossible to write to.  For the
> "accursed" ext2 dump, it recognizes the "nodump" flag, but also knows
> enough not to back up the journal file.  Sadly, neither cpio or tar
> know about ext2 attributes.
> 


Nor scp, nor rsync, nor find, nor...

	-hpa


