Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbREOWLi>; Tue, 15 May 2001 18:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261637AbREOWL2>; Tue, 15 May 2001 18:11:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53004 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261634AbREOWLU>; Tue, 15 May 2001 18:11:20 -0400
Message-ID: <3B01A97B.A61CDBDE@transmeta.com>
Date: Tue, 15 May 2001 15:11:07 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Chip Salzenberg <chip@valinux.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151746320.22958-100000@weyl.math.psu.edu> <3B01A649.A51E54DE@transmeta.com> <20010515150757.M3098@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:
> 
> According to H. Peter Anvin:
> > A device can inherently belong to multiple device classes, and it
> > really should be thought of as such.
> 
> And then there are layering technologies like LVM and loopback.
> They should be included in a discovery, but if you limit yourself
> to one "device type", there's no place for them.
> 
> > For example a disk may belong, at the same time, to the "scsi",
> > "disk" and "scsi-disk" device classes [...]
> 
> True, but in a sane system, "scsi" + "disk" implies "scsi-disk".
> 

Well, of course, but it's still a separate class.  An operation can
belong to "scsi-disk" that doesn't belong in either "scsi" or "disk". 
You can replace the - with an upside-down U if you want; it's not in
Latin-1 unfortunately.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
