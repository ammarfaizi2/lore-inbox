Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264640AbSJ3JtC>; Wed, 30 Oct 2002 04:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSJ3JtC>; Wed, 30 Oct 2002 04:49:02 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:43676
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S264640AbSJ3JtB>; Wed, 30 Oct 2002 04:49:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Miles Bader <miles@gnu.org>, Miles Bader <miles@lsi.nec.co.jp>,
       andersen@codepoet.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Wed, 30 Oct 2002 04:55:20 -0500
User-Agent: KMail/1.4.2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <20021030085149.GA7919@codepoet.org> <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp>
In-Reply-To: <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300455.20883.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 4:00, Miles Bader wrote:
> Erik Andersen <andersen@codepoet.org> writes:
> > IMHO the embedded world (as well as everyone else) wants initramfs --
> > it is a major improvement.

Erik

#1 I'll be reviewing initramfs and adding loading image from
the kernel support. I don't deny it's a godo thig to have.

#2 My main bitch at jeff was he said if initramfs goes in
initrd comes out. initrd shodul not come out.

My patch is the best of both because

> I guess I'm part of the `embedded world,' and I don't want _either_
> because they _both use RAM_!

My patch supports this (well it can be in about 5 lines of code)

Right now for backwards compatiblity I have a
initrd_from_floppy option (which replaces load_ramdisk=).
I was debating changing that to initrd_from= and then you can
spec /dev/fd0, /dev/fd1, or in your case a memory device linux
understandings.

But I mostly dimissed it because that is the job of the
boot loader....but you bring up a good point where it
could be used.

-- 
The time is now 22:48 (Totalitarian)  -  http://www.ccops.org/

