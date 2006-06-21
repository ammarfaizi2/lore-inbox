Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWFUVqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWFUVqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWFUVqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:46:31 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:19285 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751433AbWFUVqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hlKDAJks5X1oGAhmZOiy1ot6sksArtmQjP8eSatS2HL9pT2tGyMI+l/+5HqzI+l+eWud2H65qi+cnPNkTr84g8nemF/i4MUC1II3Xh3SAqOw2TzELYt8iSLMO3wVWr+PvWSi4BlE9af5UmHXnA+4Y/lLwLGKL2AOOj0RYb8D4/g=
Message-ID: <6bffcb0e0606211446v14491fdal756e1bc69763298d@mail.gmail.com>
Date: Wed, 21 Jun 2006 23:46:30 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-mm1
Cc: "Cedric Le Goater" <clg@fr.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <4499777C.7010505@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621034857.35cfe36f.akpm@osdl.org>
	 <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>
	 <20060621041758.4235dbc6.akpm@osdl.org>
	 <6bffcb0e0606210429t3e78e88dqd637718e4e22b3f0@mail.gmail.com>
	 <44994F77.5030301@fr.ibm.com> <4499777C.7010505@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 21/06/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Cedric Le Goater wrote:
> > Michal Piotrowski wrote:
> >
> >>>> usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file
> >>>> or directory
> >>> That one's probably just a parallel kbuild race.  Type `make' again.
> >>>
> >> "make O=/dir" is culprit.
> >>
> >> Regards,
> >> Michal
> >>
> >
> > That's how i fixed it. Is that the right way to do it ?
> >
>
> Probably not.  I suspect what's needed is the same EXTRA_KLIBCCFLAGS as
> in socketcalls/Kbuild.

Thanks for fixing that.

>
>         -hpa
>
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
