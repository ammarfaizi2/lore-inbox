Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315834AbSEJIXY>; Fri, 10 May 2002 04:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315836AbSEJIXX>; Fri, 10 May 2002 04:23:23 -0400
Received: from mario.gams.at ([194.42.96.10]:35106 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S315834AbSEJIXW> convert rfc822-to-8bit;
	Fri, 10 May 2002 04:23:22 -0400
Message-Id: <200205100820.g4A8K1W00658@frodo.gams.co.at>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Paul P Komkoff Jr <i@stingr.net>, Erik Andersen <andersen@codepoet.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Some useless cleanup 
In-Reply-To: <20020509222358.GB8651@codepoet.org> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 10 May 2002 10:20:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> wrote:
>char * safe_strncpy(char *dst, const char *src, size_t size)
>{
>    dst[size-1] = '\0';
>    strncpy(dst, src, size-1);
>}

Maybe just call it strlcpy() similar to others :
e.g. http://www.tac.eu.org/cgi-bin/man-cgi?strlcpy+3

	bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


