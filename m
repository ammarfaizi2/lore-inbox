Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRCELmp>; Mon, 5 Mar 2001 06:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRCELmf>; Mon, 5 Mar 2001 06:42:35 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:41487 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129166AbRCELmX> convert rfc822-to-8bit;
	Mon, 5 Mar 2001 06:42:23 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Holluby IstvBetan istvan.holluby@khb.hu" <isti@khb.hu>
Date: Mon, 5 Mar 2001 12:41:47 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Content-transfer-encoding: 8BIT
Subject: Re: [acme@conectiva.com.br: Re: mke2fs /dev/loop0]
CC: <linux-kernel@vger.kernel.org>, acme@conectiva.com.br
X-mailer: Pegasus Mail v3.40
Message-ID: <12F29251708@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Mar 01 at 12:27, Holluby Istvßn istvan.holluby wrote:
> On Wed, 28 Feb 2001, Arnaldo Carvalho de Melo wrote:
> 
>     The problem was simply, that I couldn't  cd to a directory.
> "File exist, but couldn't be stat-ed" or something similar was the
> message.

Reasonable recent kernels should display ':UUUU' instead of unknown
characters on ncpfs. Of course it requires that codepage->unicode 
translation table does not contain disallowed translations.

> > Can you be more specific? ncpfs should (and AFAIK does) compile out
> > of the box
> 
> On glibc-2.2.2      header files of select changed. So it does not
> compile cleanly. If I remember well, a define called number_of_open or
> similar was also missing. I am not sure in it thou. It might have been
> some other program.

You are using some really old ncpfs.
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
