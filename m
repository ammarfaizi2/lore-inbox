Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130678AbRCEVHD>; Mon, 5 Mar 2001 16:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbRCEVGx>; Mon, 5 Mar 2001 16:06:53 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:2063 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S130673AbRCEVGj>; Mon, 5 Mar 2001 16:06:39 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
cc: "Holluby IstvBetan istvan.holluby@khb.hu" <isti@khb.hu>,
        linux-kernel@vger.kernel.org, acme@conectiva.com.br
Message-ID: <86256A06.0073C34A.00@smtpnotes.altec.com>
Date: Mon, 5 Mar 2001 15:05:56 -0600
Subject: Re: [acme@conectiva.com.br: Re: mke2fs /dev/loop0]
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=rLzLxqpLiyvbJhw9KIwS3VaAsBgoDfIKXaz94Ast3n08xc9xv7eYkBSS"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=rLzLxqpLiyvbJhw9KIwS3VaAsBgoDfIKXaz94Ast3n08xc9xv7eYkBSS
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



What is the current version of ncpfs, and where can it be found?  The most
recent I could find (at www.ibiblio.org) was ncpfs-2.2.0 which dates back to May
1998, and I ran into the problem with select when trying to compile it on a
current system.  I got it to work by compiling it on an old 2.0.x box that I
haven't upgraded in several years, then moved it to my 2.4.x system.  It's been
working fine for several months, but I'd like to be able to compile it on a
current system without hacking the source.

Wayne




"Petr Vandrovec" <VANDROVE@vc.cvut.cz> on 03/05/2001 05:41:47 AM

To:   "Holluby IstvBetan istvan.holluby@khb.hu" <isti@khb.hu>
cc:   linux-kernel@vger.kernel.org, acme@conectiva.com.br (bcc: Wayne
      Brown/Corporate/Altec)

Subject:  Re: [acme@conectiva.com.br: Re: mke2fs /dev/loop0]



On  5 Mar 01 at 12:27, Holluby Istv
--0__=rLzLxqpLiyvbJhw9KIwS3VaAsBgoDfIKXaz94Ast3n08xc9xv7eYkBSS
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable


=DFn istvan.holluby wrote:
> On Wed, 28 Feb 2001, Arnaldo Carvalho de Melo wrote:
>
>     The problem was simply, that I couldn't  cd to a directory.
> "File exist, but couldn't be stat-ed" or something similar was the
> message.

Reasonable recent kernels should display ':UUUU' instead of unknown
characters on ncpfs. Of course it requires that codepage->unicode
translation table does not contain disallowed translations.

> > Can you be more specific? ncpfs should (and AFAIK does) compile out=

> > of the box
>
> On glibc-2.2.2      header files of select changed. So it does not
> compile cleanly. If I remember well, a define called number_of_open o=
r
> similar was also missing. I am not sure in it thou. It might have bee=
n
> some other program.

You are using some really old ncpfs.
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



=

--0__=rLzLxqpLiyvbJhw9KIwS3VaAsBgoDfIKXaz94Ast3n08xc9xv7eYkBSS--

