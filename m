Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWBCNpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWBCNpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWBCNpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:45:06 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:47648 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750780AbWBCNpE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:45:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mQZ43zxmXaP9gP1flqNxbLGaNYTzf34XLQ5ZC0gMCSHDfUff5y4aGhexw3A3S/Cgo1LIB3+KikSMv28ojHh7/xwqU3a3ybZTxsMplNy3YrfhARWDbyYMPy47k9kJ1iZGuq29t9+rvFqyPWG6Yn7/toyniFQ+Vfo4SvKacVa6QVE=
Message-ID: <b8332cb80602030545v578da09fod5174eb26dff3281@mail.gmail.com>
Date: Fri, 3 Feb 2006 15:45:03 +0200
From: Samer Azmy <samer.azmy@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jiri Slaby <xslaby@fi.muni.cz>,
       kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <1138971350.3086.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138863068.3270.6.camel@laptopd505.fenrus.org>
	 <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	 <20060202105338.E921D22AF07@anxur.fi.muni.cz>
	 <Pine.LNX.4.61.0602021750510.13212@yvahk01.tjqt.qr>
	 <1138971350.3086.0.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

do you have RAID array or a newly confiured RAID

Kind Regards
Samer

On 2/3/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 2006-02-02 at 17:51 +0100, Jan Engelhardt wrote:
> > >>> > ds: no socket drivers loaded!
> > >>> > VFS: Cannot open root device "LABEL=/" or 00:00
> > >>> change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
> > >>
> > >>ehhh??
> > >>sure it does.
> > >>
> > >>this is not a kernel feature, but an initrd feature, independent on
> > >>which kernel is used (there never was and is not a patch for this in any
> > >>distro kernel I know about)
> > >Ok, thank you for pointing that out.
> > >
> >
> > So does someone have a kernel-side patch for enabling LABEL=?
>
> I'm not aware of one existing.
>
> >  (Is the
> > kernel even able to tell the label of a filesystem, or is that specific to
> > mount(8)?)
>
> currently the kernel is fully unaware of any labels, other than having
> the space reserved in the various filesystem on disk metadata.
>
>
>
> This is one of those things that is better done in userspace really.....
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
