Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSEHGmO>; Wed, 8 May 2002 02:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSEHGmN>; Wed, 8 May 2002 02:42:13 -0400
Received: from mpdr0.milwaukee.wi.ameritech.net ([65.43.19.132]:8946 "EHLO
	mailhost.mil.ameritech.net") by vger.kernel.org with ESMTP
	id <S315539AbSEHGmM>; Wed, 8 May 2002 02:42:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: James <jdickens@ameritech.net>
To: Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: Can't Burn CDR's On 2.4.19pre8
Date: Wed, 8 May 2002 01:37:26 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.3.96.1020508040909.2702J-100000@pioneer>
Cc: Tomasz Rola <rtomek@cis.com.pl>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020508072001.WWPH3647.mailhost.mil.ameritech.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
One of problems that may be affecting us is the method used to burn. 
Is the fact that some CD-writers don't know how to to Disk at Once, and can 
only do Track at once. What I noticed, is that some versions of kernel or 
possibly hardware (such as mine Phillips CD-writer) seem to work correctly if 
you do tasks in a certain order such don't request atip info and then attempt 
to write the data as Disk at once that fails, and then write it track at 
once. but if I do Track at once the first it fails, note i have not really 
done the extensive testing of this. Just my observations, do it in the wrong 
order, the cd-writer locks up and only responds to power down. Which is verry 
fustrating, and also possibly creates a nice shiny coaster. 

I have read that Disk at Once mode works for writers that understand that 
mode of writing, but the track at once is the one that is currently broken, 
that explains why some us are complaining and others say that all is fine.

James

On Tuesday 07 May 2002 10:14 pm, Tomasz Rola wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Tue, 7 May 2002, Johannes Ruscheinski wrote:
> > Also sprach Tomasz Rola:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > On Mon, 6 May 2002, Johannes Ruscheinski wrote:
> > > > Hi,
> > > >
> > > > I don't know whether I have a hardware problem or a kernel problem. 
> > > > Here's what I get when I try to dummy burn a data CDR on 2.4.19pre8:
> > >
> > > Forgive me this insulting question, but have you tried to burn another
> > > CD?
> >
> > It was a dummy burn.  I didn't realize that the CDR medium mattered here?
> > So just to be on the safe side I tried again with a different brand disc
> > and had a failure after about 70MiB of data.
>
> Me idiot. Haven't noticed that "dummy" word. How about going back to some
> previous working kernel to try if it works? I have burnt quite a few CDRWs
> under 2.4.18 so I assume it's ok here. BTW, I always give right dev=x,y,z
> options, which I get from "cdrecord -scanbus".
>
> bye
> T.
>
> - --
> ** A C programmer asked whether computer had Buddha's nature.      **
> ** As the answer, master did "rm -rif" on the programmer's home    **
> ** directory. And then the C programmer became enlightened...      **
> **                                                                 **
> ** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: PGPfreeware 5.0i for non-commercial use
> Charset: noconv
>
> iQA/AwUBPNiKCBETUsyL9vbiEQKLmQCgjykrGtGsrdZxkwgegm/saT029DEAoNNm
> VeREzT/A9X6ga1D56XPZX2ly
> =HBJv
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
