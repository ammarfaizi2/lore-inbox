Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbREOUaI>; Tue, 15 May 2001 16:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbREOU3s>; Tue, 15 May 2001 16:29:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:1544 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261452AbREOU3o>; Tue, 15 May 2001 16:29:44 -0400
Message-ID: <3B019182.D9524691@transmeta.com>
Date: Tue, 15 May 2001 13:28:50 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zlLk-0002yl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > [ The biggest silliness is this "let's try to make the disks appear in the
> >   same order that the BIOS probes them". Now THAT is really stupid, and it
> >   goes on a lot more than I'd ever like to see. ]
> 
> RIght - Lilo needs to know but nobody else should except when they need to ask
> eg to find which disk failed
> 

There would be some value to an informational ioctl() or other query
mechanism to give the firmware identifier (BIOS on PC platforms.)  This
may, of course, be "null" in which case you need to give an error message
if you're trying to boot from it!

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
