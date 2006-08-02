Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWHBRIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWHBRIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWHBRIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:08:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:65227 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751255AbWHBRIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:08:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hxziwcw6yh3cTYBwbx4VH7yFQ+CcHfm/xLyPAVSzCFHPw4WdI/iYTp3KFlKYMi6ESq1IlEovEjqYnJYfxBgldJlAcotRl7zfBVwLTBIXMz+Zbe65t39OJ6CoIDrIDXFtrMsRjz1sTCqobKQEMtrFZUVkmvCv9qufOJV9230uLoM=
Message-ID: <dda83e780608021008t44778d98g8cdecaee35807d3f@mail.gmail.com>
Date: Wed, 2 Aug 2006 10:08:13 -0700
From: "Bret Towe" <magnade@gmail.com>
To: "Dominik Karall" <dominik.karall@gmx.net>
Subject: Re: 2.6.18-rc1-mm2 and 2.6.18-rc3 (bttv: NULL pointer derefernce)
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Mauro Carvalho Chehab" <mchehab@infradead.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <200608021800.23905.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <200607141830.01858.dominik.karall@gmx.net>
	 <200608021800.23905.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/06, Dominik Karall <dominik.karall@gmx.net> wrote:
> hi!
>
> I'm not sure if anybody is working on this bug (see below), but as it
> happens with 2.6.18-rc3 too, I think it's important to inform you to
> avoid that this bug hits the final release.
>
> thx,
> dominik

work around at least is to enable
Enable Video For Linux API 1 (DEPRECATED)
Enable Video For Linux API 1 compatible Layer
worked for me on -rc3

>
> On Friday, 14. July 2006 18:30, Dominik Karall wrote:
> > On Friday, 14. July 2006 07:48, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6
> > >.1 8-rc1/2.6.18-rc1-mm2/
> >
> > Hi,
> > just want to inform you that the bug is present in 2.6.18-rc1-mm2
> > too. But I took a better screenshot which should be readable:
> > http://stud4.tuwien.ac.at/~e0227135/kernel/IMG_5614.JPG
> >
> > I hope it's useful for you, please let me know if I should test any
> > patches!
> >
> > cheers,
> > dominik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
