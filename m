Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbQKBXrv>; Thu, 2 Nov 2000 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbQKBXrl>; Thu, 2 Nov 2000 18:47:41 -0500
Received: from [213.237.20.108] ([213.237.20.108]:26920 "EHLO ns.geekboy.dk")
	by vger.kernel.org with ESMTP id <S129304AbQKBXrb>;
	Thu, 2 Nov 2000 18:47:31 -0500
Date: Fri, 3 Nov 2000 00:50:34 +0100
From: Torben Mathiasen <torben@kernel.dk>
To: Elizabeth Morris-Baker <eamb@liu.fafner.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        chen xiangping <chen_xiangping@emc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: scsi init problem in 2.4.0-test10?
Message-ID: <20001103005034.C1353@torben>
In-Reply-To: <20001102145320.A27745@one-eyed-alien.net> <200011022245.QAA08323@liu.fafner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011022245.QAA08323@liu.fafner.com>; from eamb@liu.fafner.com on Thu, Nov 02, 2000 at 04:45:25PM -0600
X-OS: Linux 2.4.0-test10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SCSI spec says that INQUIRY and not
TUR + INQUIRY is the way to go, but maybe we
should make it a compile time option for buggy
drives.


On Thu, Nov 02 2000, Elizabeth Morris-Baker wrote:
> > 
> 
> 	You need to send the TUR first, but yes, 
> 	START_STOP will guarantee that you are
> 	ready to rock and roll.
> 	The first fix I wrote did a TUR, then
> 	3 tries at a START_STOP, till it worked.
> 	
> 	cheers, 
> 
> 	Elizabeth
>

[deleted]

-- 
Torben Mathiasen <tmm@kernel.dk>
Linux ThunderLAN maintainer 
http://tlan.kernel.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
