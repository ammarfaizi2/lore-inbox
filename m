Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291619AbSBNNQT>; Thu, 14 Feb 2002 08:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291621AbSBNNP7>; Thu, 14 Feb 2002 08:15:59 -0500
Received: from linux.kappa.ro ([194.102.255.131]:47565 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S291619AbSBNNPx>;
	Thu, 14 Feb 2002 08:15:53 -0500
Date: Thu, 14 Feb 2002 15:17:30 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: weird system load (2.4.18-pre3)
In-Reply-To: <E16bLJI-0008LG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0202141514450.17391-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

 Ok, we have 2 Intel Etherexpress (eepro100.c) 82557. SCSI drives on a
Adaptec AIC7xxx board ( 7892B ).
>
> > ext3 mounted, and we had a lot of problems with ext3 when reaching maximum
> > capacity ( after reboot had a lot of fatal errors ), but that seemed to
>
> Thats not a good sign for trusting the machine either
  We also get lots of APIC error on CPU ..etc.. ( about 20 a day )
>
> > passed, and now we are getting this unusual load, plus the system is not
> > so reponsive.
>
> Not so responsive as when ?  also what is in the dmesg log ?
 I meant not as responsive as right after the startup or when we used 2.2.
kernel, now there is still something I forgot to mention, and that would
be the fact that we stil use ipchains compatibility mode ( because of some
huge scripts that we were too lazy to convert ). Today I converted them
but I didn't reboot yet, maybe we can find a bug after all ?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

