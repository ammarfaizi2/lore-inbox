Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSDEIhg>; Fri, 5 Apr 2002 03:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312395AbSDEIhZ>; Fri, 5 Apr 2002 03:37:25 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:42192 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S312393AbSDEIhP>; Fri, 5 Apr 2002 03:37:15 -0500
Date: Fri, 5 Apr 2002 10:37:06 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Oleg Drokin <green@namesys.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] reiserfs error message at boot-time
In-Reply-To: <20020405122035.A14561@namesys.com>
Message-ID: <Pine.LNX.4.40.0204051035010.13870-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Oleg Drokin wrote:

> Hello!
>
> On Fri, Apr 05, 2002 at 10:03:47AM +0200, Daniel Nofftz wrote:
>
> > i just moved my linux partitition from ext3 to reiserfs.
> > now my problem:
> > when i boot, i get this error-message:
> > reiserfs: Unrecognized mount option errors
> > reiserfs: Unrecognized mount option errors
>
> Can you show content of your /etc/fstab?
> It complains you passed it unrecognised "errors" option.

/dev/hda2       /               reiserfs        defaults,errors=remount-ro
0       1

i think it's the "errors=remount-ro" then, or ?

daniel



# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

