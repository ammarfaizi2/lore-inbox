Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130052AbRBKUcc>; Sun, 11 Feb 2001 15:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130239AbRBKUcW>; Sun, 11 Feb 2001 15:32:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25101 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130148AbRBKUcL>; Sun, 11 Feb 2001 15:32:11 -0500
Message-ID: <3A86F6AA.1416F479@transmeta.com>
Date: Sun, 11 Feb 2001 12:31:38 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
In-Reply-To: <20010211211701.A7592@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> 
> Hi,
> 
> there is a race in 2.4.1 and 2.4.2-pre3 in autofs/nfs.
> When the cwd is on the nfs mounted server (== busy) and you try to
> reboot the shutdown hangs in "rcautofs stop". I can reproduce it everytime.
> 

Sounds like an NFS bug in umount.

	-=hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
