Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129607AbRBBLgv>; Fri, 2 Feb 2001 06:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129605AbRBBLgc>; Fri, 2 Feb 2001 06:36:32 -0500
Received: from [208.41.174.68] ([208.41.174.68]:57093 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S129442AbRBBLga>;
	Fri, 2 Feb 2001 06:36:30 -0500
In-Reply-To: <14969.45148.886179.74191@somanetworks.com>
To: linux-kernel@vger.kernel.org
From: Paul Collins <sneakums@zork.net>
Subject: Re: problems with devfsd compilation
Date: 02 Feb 2001 11:36:29 +0000
Message-ID: <6uy9vppb9e.fsf@zork.zork.net>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Georg Nikodym (georgn@somanetworks.com) wrote:

> Also, RH7's /etc/rc.sysinit can already start devfsd automatically
> with the following line:
> 
>     [ -e /dev/.devfsd -a -x /sbin/devfsd ] && /sbin/devfsd /dev
> 
> So, all you have to do is create an empty file /dev/.devfsd

That file is created by devfs itself, and is used for communication
with devfsd.  What the check for that file accomplishes is to only
start devfsd if devfs is mounted.

-- 
<sneakums@zork.net> >>>>>>> >>>>>> >>>>> >>>> >>> >> >
< << <<< This used to be real-estate,
         now it's only fields and trees. >>>> >>> >> >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
