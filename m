Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAKMKj>; Thu, 11 Jan 2001 07:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbRAKMK3>; Thu, 11 Jan 2001 07:10:29 -0500
Received: from Cantor.suse.de ([194.112.123.193]:7951 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129842AbRAKMKJ>;
	Thu, 11 Jan 2001 07:10:09 -0500
Date: Thu, 11 Jan 2001 13:10:05 +0100
From: Andi Kleen <ak@suse.de>
To: Manfred <manfred@colorfullife.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010111131005.A23611@gruyere.muc.suse.de>
In-Reply-To: <200101110734.f0B7Y1x01512@flint.arm.linux.org.uk> <979215027.3a5da2b3781d7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <979215027.3a5da2b3781d7@localhost>; from manfred@colorfullife.com on Thu, Jan 11, 2001 at 07:10:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 07:10:27AM -0500, Manfred wrote:
> Zitiere Russell King <rmk@arm.linux.org.uk>:
> > The API changed:
> >  struct nfs_mount_data {
> >         int             version;                /* 1 */
> >         int             fd;                     /* 1 */
> > -       struct nfs_fh   root;                   /* 1 */
> > +       struct nfs2_fh  old_root;               /* 1 */
> 
> I don't see an API change:
> the 2.2.17 "struct nfs_fs" and the 2.2.18 "struct nfs2_fh" are identical.

But it changed in 2.2.19pre, breaking nfs mount on i386. 




-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
