Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278218AbRJRX7r>; Thu, 18 Oct 2001 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278221AbRJRX7h>; Thu, 18 Oct 2001 19:59:37 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:34705 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S278218AbRJRX7X>; Thu, 18 Oct 2001 19:59:23 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 18 Oct 2001 15:38:36 -0700 (PDT)
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <20011018180705.B13661@lug-owl.de>
Message-ID: <Pine.LNX.4.40.0110181536290.8316-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so what will the export_symbol_gpl stuff do with the BSD license? it may
or may not have source avilable so is it allowed to use the exported
symbols or not?

for the tainting module process there is the same problem.

knowing the license the code was released under does not tell you if the
source is available or not.

David Lang


 On Thu, 18 Oct 2001, Jan-Benedict Glaw wrote:

> Date: Thu, 18 Oct 2001 18:07:06 +0200
> From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
> To: linux-kernel@vger.kernel.org
> Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
>
> On Thu, 2001-10-18 11:43:15 -0500, Roy Murphy <murphy@panix.com>
> wrote in message <3bcef893.4872.0@panix.com>:
> > 'Twas brillig when Arjan van de Ven scrobe:
> > >I think you're missing one thing: binary only modules are only allowed
> > >because of an exception license grant Linus made for functions that are
> > >marked EXPORT_SYMBOL(). EXPORT_SYMBOL_GPL() just says "not part of
> > >this exception grant"....
> >
> > of the Copyright to the kernel to grant or to restrict.  Does Microsoft have
> > a legal right to disallow any third-party drivers from
> > registering themselves with the OS?  Does Linus?
>
> They do, but they won't use it. They want to *sell* windows and they're
> (more or less) willing to decode their blue screens produced by 3rd
> vendor's drivers. However, GPL people may (or may not) be willing to
> spend time in searching bugs in other company's drivers. However, *I* am
> not willig to do other people's job, especially if *they* earn money
> therefor...
>
> MfG, JBG
>
> --
> Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
