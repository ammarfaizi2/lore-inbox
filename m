Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266103AbRGGLe7>; Sat, 7 Jul 2001 07:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266104AbRGGLet>; Sat, 7 Jul 2001 07:34:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40135 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266103AbRGGLek>;
	Sat, 7 Jul 2001 07:34:40 -0400
Message-ID: <3B46F3CE.9002ABAB@mandrakesoft.com>
Date: Sat, 07 Jul 2001 07:34:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eugene Crosser <crosser@average.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com> <9i6oga$jk1$1@pccross.average.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Crosser wrote:
> 
> In article <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>,
>         Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > I don't like the current initrd very much myself, I have to admit. I'm not
> > going to accept a "you have to have a ramdisk" approach - I think the
> > ramdisks are really broken.
> >
> > But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
> > patch somewhere, and that would be a whole lot more palatable to me.
> 
> Doesn't the approach "treat a chunk of data built into bzImage as
> populated ramfs" look cleaner?  No need to fiddle with tar format,
> no copying data from place to place.

So tell me, how do you populate ramfs without a format which tells you
what path and which permissions to assign each file?  That's exactly
what tar is.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
