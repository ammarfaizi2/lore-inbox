Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSANT5O>; Mon, 14 Jan 2002 14:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288954AbSANT40>; Mon, 14 Jan 2002 14:56:26 -0500
Received: from [208.29.163.248] ([208.29.163.248]:49315 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S288952AbSANTzH>; Mon, 14 Jan 2002 14:55:07 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: babydr@baby-dragons.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Jan 2002 11:54:27 -0800 (PST)
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <E16QCc6-0002bb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0201141152570.22904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

note: this discussion has moved away from autoconfig to requiring
everything to be modules.

autoconfig is a useful tool in some cases, but is not going to be used
everywhere.

I view modules as being in the same catagory.

David Lang


On Mon, 14 Jan 2002, Alan Cox wrote:

> Date: Mon, 14 Jan 2002 19:17:46 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: babydr@baby-dragons.com
> Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
> Subject: Re: Hardwired drivers are going away?
>
> > > Urban legend.
> > 	I do not agree .  Got proof ?  Yes that is a valid question .
>
> Most of the rootkit type stuff I see nowdays includes code for loading
> patches into module free kernels. Its a real no win. The better ones support
> regexp scanning so they can patch kernels where the sysadmin thinks he/she
> is cool and has hidden or crapped in System.map
>
> > > > case becouse the system can't know where the module will be located IIRC)
> > > I defy you to measure it on x86
> > 	OK ,How about sparc-64/alpha/ia64/... ?
>
> Not generally found in your grandmothers PC
>
> > > > 3. simplicity in building kernels for other machines. with a monolithic
> > > > kernel you have one file to move (and a bootloader to run) with modules
> > > > you have to move quite a few more files.
> > > tar or nfs mount; make modules_install.
> > 	Please my laugh'o meter is stuck already .  Sorry .  JimL
>
> Then fix it, because the above works well. Also remember that autoconfig
> tools won't be able to guess remote machines very well 8)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
