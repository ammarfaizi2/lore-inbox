Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281454AbRKRVqI>; Sun, 18 Nov 2001 16:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280132AbRKRVp7>; Sun, 18 Nov 2001 16:45:59 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:6480 "EHLO
	c0mailgw07.prontomail.com") by vger.kernel.org with ESMTP
	id <S281458AbRKRVpu>; Sun, 18 Nov 2001 16:45:50 -0500
Message-ID: <3BF82BF8.51A8F1D4@starband.net>
Date: Sun, 18 Nov 2001 16:45:28 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <E165ZRi-000718-00@mauve.csi.cam.ac.uk> <3BF827E1.5A2C7427@starband.net> <3BF82B3C.8070303@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I completely agree with you.
p3/866/1024MB here.
Everything seems much faster; and I can run 512 processes of varying memory
"weights" without a hitch.

François Cami wrote:

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

