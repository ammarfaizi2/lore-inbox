Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSJ3Jaj>; Wed, 30 Oct 2002 04:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSJ3Jaj>; Wed, 30 Oct 2002 04:30:39 -0500
Received: from codepoet.org ([166.70.99.138]:30109 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264638AbSJ3JaW>;
	Wed, 30 Oct 2002 04:30:22 -0500
Date: Wed, 30 Oct 2002 02:36:44 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Miles Bader <miles@gnu.org>, Dave Cinege <dcinege@psychosis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Message-ID: <20021030093644.GA8423@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@pobox.com>, Miles Bader <miles@gnu.org>,
	Dave Cinege <dcinege@psychosis.com>, linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com> <200210300322.17933.dcinege@psychosis.com> <20021030085149.GA7919@codepoet.org> <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp> <3DBFA0F8.9000408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBFA0F8.9000408@pobox.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 30, 2002 at 04:06:00AM -0500, Jeff Garzik wrote:
> Miles Bader wrote:
> >[Well, OK, actually it'd be nice to have something like initramfs + some
> >other sort of fetch-the-bits-directly-from-ROM FS which I could
> >mix-n-match; anyway initramfs has got to be better than initrd...]
> > 
> >
> 
> It should be pretty easy to populate initramfs from ROM...

I imagine so.  But that still leaves everything in RAM.  On a
system with just 1 or 2 MB of ram (I have run Linux on such
things :-) there really isn't much point in trying to use any
sortof ramfs.  Its just not going to work.  For that type of
application you really want something like JFFS, JFFS2 and
whatnot living in ROM/flash.  But I'm sure someone could find 
a reason for a *ramfs to be useful, even then.... :)

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
