Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131266AbRACMeB>; Wed, 3 Jan 2001 07:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131458AbRACMdw>; Wed, 3 Jan 2001 07:33:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:17426 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131266AbRACMdi>;
	Wed, 3 Jan 2001 07:33:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.3.24 is available 
In-Reply-To: Your message of "Wed, 03 Jan 2001 12:40:05 BST."
             <20010103124005.A5179@emma1.emma.line.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jan 2001 23:03:05 +1100
Message-ID: <13828.978523385@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001 12:40:05 +0100, 
Matthias Andree <matthias.andree@stud.uni-dortmund.de> wrote:
>On Wed, 03 Jan 2001, Keith Owens wrote:
>
>> Matthias Andree <matthias.andree@stud.uni-dortmund.de> wrote:
>> >There's a problem. depmod should not try to do anything besides giving
>> >its version when --version is used, should it?
>> 
>> Historical accident.  I want to clean that up but it breaks existing
>> behaviour;
>
>Okay, backwards compatibility weighs a lot.
>
>May I kindly ask you to give a note that -V does NOT terminate the
>program, but also comprises regular operation in --help and the man
>pages? 
>
>I can send in a patch if you want (that just changes the docs, but not
>the functionality).

Don't bother.  It will change in 2.5 anyway, I can live with the odd
query until then.  If you really want to get only the version number
then this will work for modutils 2.x for x >= 3.

  (/sbin/depmod -V -n | head -1) 2>/dev/null

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
