Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291717AbSBNPnk>; Thu, 14 Feb 2002 10:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291720AbSBNPnb>; Thu, 14 Feb 2002 10:43:31 -0500
Received: from linux.kappa.ro ([194.102.255.131]:53200 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S291717AbSBNPnY>;
	Thu, 14 Feb 2002 10:43:24 -0500
Date: Thu, 14 Feb 2002 17:45:01 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: weird system load (2.4.18-pre3) (last)
In-Reply-To: <E16bLJI-0008LG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0202141744190.24469-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems the problem was because of a hidden process, so no worries about
the kernel anymore :)

On Thu, 14 Feb 2002, Alan Cox wrote:

> > I have a linux router running 2.4.18-pre3 kernel and I've got the
> > following problem with it:
> >
> > It doesn't have free cpu, more than 75% of the resources go to system:
>
> Well its paging somewhat which suprises me, but unless your disks are in PIO
> mode I would not expect it to account for that.
>
> What network and disk drivers are you using ?
>
> > ext3 mounted, and we had a lot of problems with ext3 when reaching maximum
> > capacity ( after reboot had a lot of fatal errors ), but that seemed to
>
> Thats not a good sign for trusting the machine either
>
> > passed, and now we are getting this unusual load, plus the system is not
> > so reponsive.
>
> Not so responsive as when ?  also what is in the dmesg log ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

