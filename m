Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132029AbRA1KKu>; Sun, 28 Jan 2001 05:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRA1KKj>; Sun, 28 Jan 2001 05:10:39 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:32067 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132029AbRA1KKU>; Sun, 28 Jan 2001 05:10:20 -0500
Message-ID: <3A73EFE8.3FB7BEC0@linux.com>
Date: Sun, 28 Jan 2001 10:09:44 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@cygnus.com>
CC: Pierre Rousselet <pierre.rousselet@wanadoo.fr>, devfs@oss.sgi.com,
        rgooch@atnf.csiro.au, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfsd, compiling on glibc22x
In-Reply-To: <3A7383B2.19DDD006@linux.com> <3A73C1D8.578AEEE@wanadoo.fr> <m3wvbgnnk3.fsf@otr.mynet.cygnus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:

> Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:
>
> > for me :
> > make CFLAGS='-O2 -I. -D_GNU_SOURCE'
> > compiles without any patch. is it correct ?
>
> Yes.  RTLD_NEXT is not in any standard, it's an extension available
> via -D_GNU_SOURCE.

Ok, how about we all tag Richard until he adds that to the makefile?  :)

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
