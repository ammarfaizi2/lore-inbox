Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280161AbRKSHIf>; Mon, 19 Nov 2001 02:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRKSHI1>; Mon, 19 Nov 2001 02:08:27 -0500
Received: from smtp-out.student.liu.se ([130.236.230.80]:56875 "EHLO
	elysium.student.liu.se") by vger.kernel.org with ESMTP
	id <S280161AbRKSHIJ> convert rfc822-to-8bit; Mon, 19 Nov 2001 02:08:09 -0500
Date: Mon, 19 Nov 2001 00:03:22 +0100
From: Erik Gustavsson <cyrano@algonet.se>
Subject: Re: Swap
In-Reply-To: <3BF82B3C.8070303@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Message-id: <1006124602.3890.0.camel@bettan>
MIME-version: 1.0
X-Mailer: Evolution/0.99.0 (Preview Release)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
In-Reply-To: <3BF82443.5D3E2E11@starband.net>
 <E165ZRi-000718-00@mauve.csi.cam.ac.uk> <3BF827E1.5A2C7427@starband.net>
 <3BF82B3C.8070303@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree...   After a while it always seems that 80% or more of my RAM is
used for cache and buffers while my open, but not currently used apps
get pushed onto disk. Then when I decide to switch to that mozilla
window of emacs session I have to wait for it to be loaded from disk
again. Also considering the kind of disk activity this box has, the data
in the cache is mostly the last few hour's MP3's, in other words utterly
useless as that data will not be used again. I'd rather my apps stayed
in RAM...

Is there a way to limit the size of the cache?

/cyr

> 
> I don't understand why it should be better with swap then... I mean,
> my comp seems to run so much faster (it doesn't take time to switch
> from one app to another, i mean) *without* swap.
> And I see no benefits to having an active swap, other than making my
> hard drive work harder.
> 
> comp is PIII933/512MB on ATA100
> kernel is 2.4.14 with XFS patch.
> 
> François
> 
> 
> war wrote:
> 
> > Well, without the swap, everything seems to be about 100% more responsive when
> > I execute any task.
> > I see how it works now.
> > 
> > James A Sutherland wrote:
> > 
> > 
> >>On Sunday 18 November 2001 9:12 pm, war wrote:
> >>
> >>>It is amazing that I could run all of that stuff, because:
> >>>
> >>>When I have swap on, and if I run all of those programs, 200-400MB of
> >>>swap is used.
> >>>
> >>Yep. There's a reason for that: the kernel is *ALWAYS* able to swap pages out
> >>to disk - even without "swap space". Disabling swapspace simply forces the
> >>kernel to swap out more code, since it cannot swap out any data.
> >>
> >>(This is why you can still get "disk thrashing" without any swap - in fact,
> >>it's more likely in this case than it is with some swap added - you are just
> >>forcing your binaries to take more of the swapping load instead.)
> >>
> >>So: with swapspace, the kernel swaps out a few hundred Mb of unused data, to
> >>make room for more code. Without it, the kernel is forced to swap out code
> >>pages instead. The big news here is...?
> >>
> >>James.
> >>
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
-- 
-----------------------------------------------------------------------
Holly: Purple alert! Purple alert!
Lister: What's a purple alert?
Holly: Well, it's like not as bad as a red a alert, but a bit worse
than a blue alert -- sort of a mauve alert.

