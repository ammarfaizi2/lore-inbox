Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbRE3Qfm>; Wed, 30 May 2001 12:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbRE3Qfd>; Wed, 30 May 2001 12:35:33 -0400
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.112]:40746 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S261487AbRE3QfS>;
	Wed, 30 May 2001 12:35:18 -0400
Message-ID: <3B152146.82299CA2@violin.dyndns.org>
Date: Wed, 30 May 2001 18:35:18 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tori@unhappy.mine.nu,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com> <3B14493E.63F861E7@mandrakesoft.com> <20010529182506.A14727@bougret.hpl.hp.com> <3B145127.5B173DFF@mandrakesoft.com> <20010529190152.A14806@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> > This is ANSI C standard stuff.  If a static object with a scalar type is
> > not explicitly initialized, it is initialized to zero by default.
> >
> > Sure we can get gcc to recognize that case, but why use gcc to work
> > around code that avoids an ANSI feature?
> 
>         Good standard don't mandate the implementation. And as
> somebody doing some other language said, there is more than one way to
> do it.

Hmmm, I understand both sides perfectly, but what about that one:

int n; /* n=0 */

Would that be a compromise?

		Regards,
		Hermann


-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
