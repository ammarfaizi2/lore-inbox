Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130599AbQK0RaL>; Mon, 27 Nov 2000 12:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132212AbQK0RaB>; Mon, 27 Nov 2000 12:30:01 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:36623 "EHLO
        devserv.devel.redhat.com") by vger.kernel.org with ESMTP
        id <S130599AbQK0R3z>; Mon, 27 Nov 2000 12:29:55 -0500
Date: Mon, 27 Nov 2000 11:59:42 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jes Sorensen <jes@linuxcare.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001127115942.B1514@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <1604.975280988@kao2.melbourne.sgi.com> <d3ofz11hur.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <d3ofz11hur.fsf@lxplus015.cern.ch>; from jes@linuxcare.com on Mon, Nov 27, 2000 at 05:48:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 05:48:28PM +0100, Jes Sorensen wrote:
> >>>>> "Keith" == Keith Owens <kaos@ocs.com.au> writes:
> 
> Keith> On Sun, 26 Nov 2000 16:36:55 -0700, "Jeff V. Merkey"
> Keith> <jmerkey@vger.timpanogas.org> wrote:
> >> Keith,
> >> 
> >> Please consider the attached patch for inclusion in all future
> >> versions of the modutils depmod program for compatiblity with
> >> RedHat and RedHat derived Linux distributions.
> 
> Keith> I have a big problem with Redhat.  They make incompatible
> Keith> changes to utilities, do not feed patches back to maintainers
> Keith> then expect the rest of the world to follow their lead.  The -i
> Keith> and -m flags to modutils are not the only example, I recently
> Keith> found IA64 and Sparc patches they had added to modutils code
> Keith> and not bothered to tell me.  Other distributors are much
> Keith> better about sending me patches, Debian and SuSe in particular
> Keith> do the right thing.
> 
> I don't remember where the ia64 modutils patches come from, there were
> some floating around between the ia64 developers for a while. The
> sparc patches I don't have a clue about where come from.

The sparc patches were not sent just because of lack of time on my part,
Jeff Johnson wrote it so that modules compiled with sparc64 gcc 2.96
(basically anything which generates OLO10 relocations) can be inserted and I
wanted to review/test it first myself (and did not get to it early enough).

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
