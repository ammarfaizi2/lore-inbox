Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130702AbRBLRj3>; Mon, 12 Feb 2001 12:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbRBLRjT>; Mon, 12 Feb 2001 12:39:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130671AbRBLRjJ>; Mon, 12 Feb 2001 12:39:09 -0500
Message-ID: <3A881FA7.2C5C8CBE@transmeta.com>
Date: Mon, 12 Feb 2001 09:38:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, autofs@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
In-Reply-To: <20010211211701.A7592@suse.de> <3A86F6AA.1416F479@transmeta.com> <shsbss8i8iq.fsf@charged.uio.no> <20010212111448.A28932@suse.de> <20010212125115.B30552@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> 
> The autofs4.o is the culprit, it works perfect with autofs.o.
> 
> What would happen if I stick with autofs.o now?
> The docu recommends autofs4 in modules.conf.
> 

I don't know who came up with that idea.  You should use the module that
matches your daemon, and not try to hack around so that there is a
module/daemon mismatch.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
