Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTAXTTC>; Fri, 24 Jan 2003 14:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTAXTTB>; Fri, 24 Jan 2003 14:19:01 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:39119 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S262380AbTAXTTB>; Fri, 24 Jan 2003 14:19:01 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Anoop J." <cs99001@nitc.ac.in>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Jan 2003 11:14:50 -0800 (PST)
Subject: Re: your mail
In-Reply-To: <57047.210.212.228.78.1043401756.webmail@mail.nitc.ac.in>
Message-ID: <Pine.LNX.4.44.0301241110470.10187-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the cache never sees the virtual addresses, it operated excclusivly on the
physical addresses so the problem of aliasing never comes up.

virtual to physical addres mapping is all resolved before anything hits
the cache.

David Lang

On Fri, 24 Jan 2003, Anoop J. wrote:

> Date: Fri, 24 Jan 2003 15:19:16 +0530 (IST)
> From: Anoop J. <cs99001@nitc.ac.in>
> To: david.lang@digitalinsight.com
> Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
> Subject: Re: your mail
>
> ok i shall put it in another way
> since virtual indexing is a representation of the virtual memory,
> it is possible for more multiple virtual addresses to represent the same
> physical address.So the problem of aliasing occurs in the cache.Does page
> coloring guarantee a unique mapping of physical address.If so how is the
> maping from virtual to physical address
>
>
>
> Thanks
>
>
>
> > I think this is a case of the same tuerm being used for two different
> > purposes. I don't know the use you are refering to.
> >
> > David Lang
> >
> >
> >
>
>
>
>
