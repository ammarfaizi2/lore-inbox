Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129527AbRBLSQG>; Mon, 12 Feb 2001 13:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130350AbRBLSPz>; Mon, 12 Feb 2001 13:15:55 -0500
Received: from ns.suse.de ([213.95.15.193]:5135 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129527AbRBLSPu>;
	Mon, 12 Feb 2001 13:15:50 -0500
Date: Mon, 12 Feb 2001 18:48:16 +0100
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, autofs@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
Message-ID: <20010212184816.C3778@suse.de>
In-Reply-To: <20010211211701.A7592@suse.de> <3A86F6AA.1416F479@transmeta.com> <shsbss8i8iq.fsf@charged.uio.no> <20010212111448.A28932@suse.de> <20010212125115.B30552@suse.de> <3A881FA7.2C5C8CBE@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A881FA7.2C5C8CBE@transmeta.com>; from hpa@transmeta.com on Mon, Feb 12, 2001 at 09:38:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, H. Peter Anvin wrote:

> Olaf Hering wrote:
> > 
> > The autofs4.o is the culprit, it works perfect with autofs.o.
> > 
> > What would happen if I stick with autofs.o now?
> > The docu recommends autofs4 in modules.conf.
> > 
> 
> I don't know who came up with that idea.  You should use the module that
> matches your daemon, and not try to hack around so that there is a
> module/daemon mismatch.

cantaloupe:~ # /usr/sbin/automount -v 
Linux automount version 4.0.0


We had 4.0pre7 in 7.0 and 4.0pre9 in 7.1.
I would really like to know _where_ it hangs, Trond sent me a printk
patch but this one was not called. 
I will try to get a i386 SMP machine to see if its ppc specific.


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
