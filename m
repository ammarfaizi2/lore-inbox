Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129777AbQK0RTA>; Mon, 27 Nov 2000 12:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130180AbQK0RSv>; Mon, 27 Nov 2000 12:18:51 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:36612 "EHLO smtp1.cern.ch")
        by vger.kernel.org with ESMTP id <S129777AbQK0RSi>;
        Mon, 27 Nov 2000 12:18:38 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
In-Reply-To: <1604.975280988@kao2.melbourne.sgi.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 27 Nov 2000 17:48:28 +0100
In-Reply-To: Keith Owens's message of "Mon, 27 Nov 2000 10:23:08 +1100"
Message-ID: <d3ofz11hur.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Keith" == Keith Owens <kaos@ocs.com.au> writes:

Keith> On Sun, 26 Nov 2000 16:36:55 -0700, "Jeff V. Merkey"
Keith> <jmerkey@vger.timpanogas.org> wrote:
>> Keith,
>> 
>> Please consider the attached patch for inclusion in all future
>> versions of the modutils depmod program for compatiblity with
>> RedHat and RedHat derived Linux distributions.

Keith> I have a big problem with Redhat.  They make incompatible
Keith> changes to utilities, do not feed patches back to maintainers
Keith> then expect the rest of the world to follow their lead.  The -i
Keith> and -m flags to modutils are not the only example, I recently
Keith> found IA64 and Sparc patches they had added to modutils code
Keith> and not bothered to tell me.  Other distributors are much
Keith> better about sending me patches, Debian and SuSe in particular
Keith> do the right thing.

I don't remember where the ia64 modutils patches come from, there were
some floating around between the ia64 developers for a while. The
sparc patches I don't have a clue about where come from.

That said I think you are pointing out a very valid problem. The same
problem exists within the kernel, I see it every so often that someone
decides to hack one a drivers and send the patch to Linus without
bothering to even Cc the author a copy. Sometimes this is 'just' to
make it compliant with the latest development kernel but Cc'ing the
maintainer is not too much to expect.

I would also like to encourage people to contact a maintainer if they
want to make extensive changes to a bit of code someone else
maintains. It is not uncommon that the maintainer already has an idea
about how to do something and might even be working on it. It is a
waste of his/her (and other peoples') time to have two conflicting
development like this going.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
