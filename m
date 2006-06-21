Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWFUONM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWFUONM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWFUONM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:13:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:50376 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751063AbWFUONK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:13:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DYhiYg81uG/073wwjBKOwqempriiBXBHh9P2nX1G85Jnz0FP9QaF+u3zAu2gYenix3EBFkr9+QPuxjTOWCEglCsFCOP1Wd8iZBeJPCOBu03WJYRuBkJ3KuTa+caiqA2ZmEOES+fI2VLi2iYTimato7hqzD/W8PQZpPL3aI1HS98=
Message-ID: <6bffcb0e0606210713g2e48bb3coa0426873e4be7995@mail.gmail.com>
Date: Wed, 21 Jun 2006 16:13:10 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Cedric Le Goater" <clg@fr.ibm.com>
Subject: Re: 2.6.17-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, hpa@zytor.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <44994F77.5030301@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621034857.35cfe36f.akpm@osdl.org>
	 <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>
	 <20060621041758.4235dbc6.akpm@osdl.org>
	 <6bffcb0e0606210429t3e78e88dqd637718e4e22b3f0@mail.gmail.com>
	 <44994F77.5030301@fr.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cedric,

On 21/06/06, Cedric Le Goater <clg@fr.ibm.com> wrote:
> Michal Piotrowski wrote:
>
> >> > usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file
> >> > or directory
> >>
> >> That one's probably just a parallel kbuild race.  Type `make' again.
> >>
> >
> > "make O=/dir" is culprit.
> >
> > Regards,
> > Michal
> >
>
> That's how i fixed it.

Problem fixed, thanks.

> Is that the right way to do it ?
>
> Thanks,
>
> C.
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
