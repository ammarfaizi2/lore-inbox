Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRHGWEW>; Tue, 7 Aug 2001 18:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269478AbRHGWED>; Tue, 7 Aug 2001 18:04:03 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:19184 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269477AbRHGWDw>; Tue, 7 Aug 2001 18:03:52 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108072202.f77M2ikt017668@webber.adilger.int>
Subject: Re: [RFC][PATCH] parser for mount options
In-Reply-To: <200108072151.VAA25091@vlet.cwi.nl> "from Andries.Brouwer@cwi.nl
 at Aug 7, 2001 09:51:06 pm"
To: Andries.Brouwer@cwi.nl
Date: Tue, 7 Aug 2001 16:02:44 -0600 (MDT)
CC: torvalds@transmeta.com, viro@math.psu.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreis writes:
> I did the same for 1.3.61 long ago. A fragment:
> with call for each filesystem
> 
> 	parse_mount_options((char *) data, SIZE(opts), opts);
> 
> I am not sure which of the two versions I prefer.
> For example, the above setup shows very clearly what the defaults are.

What else is nice about this variant is that you don't need to change
the prototype for parse_options() each time you add a new parameter,
you only pass the "opts" struct around.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

