Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSEYRfo>; Sat, 25 May 2002 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSEYRfn>; Sat, 25 May 2002 13:35:43 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:33708 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S314101AbSEYRfm>; Sat, 25 May 2002 13:35:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524071657.GI21164@dualathlon.random>
	<Pine.LNX.4.44.0205240737400.26171-100000@home.transmeta.com>
	<20020524105348.T13411@devserv.devel.redhat.com>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Sat, 25 May 2002 19:33:27 +0200
Message-ID: <87adqo9lp4.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> In glibc 2.3 this will be open("/usr/lib/locale/locale-archive", ), so
> negative dentries won't be useful for glibc locale handling (that
> doesn't mean negative dentries won't be useful for other things, including
> exec?p or searching libraries if $LD_LIBRARY_PATH is used).

I guess Apache's .htaccess checking benefits from negative caching,
too.

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
