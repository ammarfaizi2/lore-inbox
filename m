Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272232AbRH3OY7>; Thu, 30 Aug 2001 10:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272233AbRH3OYk>; Thu, 30 Aug 2001 10:24:40 -0400
Received: from [209.10.41.242] ([209.10.41.242]:30926 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272232AbRH3OYS>;
	Thu, 30 Aug 2001 10:24:18 -0400
Date: Thu, 30 Aug 2001 15:05:12 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "=?iso-8859-1?q?Mark=20A.=20Tagliaferro?=" <be_lak@yahoo.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with compiling kernel.
In-Reply-To: <20010830103609.96135.qmail@web14701.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0108301503450.20468-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stupid question....

And then did you compile and install the modules too?

it seems you installed the new kernel (2.4.2, an old one to say the
truth), but not the new modules

bye
Luigi

On Thu, 30 Aug 2001, Mark A. Tagliaferro wrote:

> I'm using SuSE 7.1 and I had to compile the kernel to include SCSI support.
> That part is all well and good.  The problems started when I tried to set up
> masquerading.  Modprobe is returning the following error:
>
> modprobe: Can't open dependencies file /lib/modules/2.4.2/modules.dep (No such
> file or directory)
>
> I looked in /lib/modules/ and there the directory is called 2.4.2-4GB and not
> 2.4.2
>
> I tried to fool it by creating a virtual link to the directory with the name
> 2.4.2 but then the modprobe returns a large number of kernal mismatch errors
> that the particular modules (iptable_nat) I am trying to run were written for
> kernel version 2.4.2-4GB and not 2.4.2
>
> It looks like modprobe is looking for kernel version 2.4.2 but the modules are
> for kernel 2.4.2-4GB.
>
> Incidentally I have another machine with the standard kernel that YaST installs
> on which modprobe works well and the directory in /lib/modules/ is calle
> 2.4.2-4GB.
>
> Any idea as to what I'm doing wrong?
> Did I have to recompile the kernel to load the aic7xxx or could I have added a
> command in some initialisation file to load it as a module (insmod)?
>
> Regards
> Mark
>
>
> ____________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
> or your free @yahoo.ie address at http://mail.yahoo.ie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

