Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290585AbSARCFn>; Thu, 17 Jan 2002 21:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290584AbSARCFd>; Thu, 17 Jan 2002 21:05:33 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:13843 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290585AbSARCFS>; Thu, 17 Jan 2002 21:05:18 -0500
Message-ID: <3C4782BA.906950C8@m3its.de>
Date: Fri, 18 Jan 2002 03:04:42 +0100
From: Klaus Meyer <k.meyer@m3its.de>
Organization: m3ITS
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, rwhron@earthlink.net, bcrl@redhat.com
Subject: Re: highmem=system killer, 2.2.17=performance killer ?
In-Reply-To: <3C439E6D.B2B8C5B8@m3its.de>
		<20020115160018.18793569.skraw@ithnet.com>
		<3C445BFC.E373EA04@m3its.de> <20020115174918.11a3bafc.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

thank you very much for your convenience and effort.
I've now located the real reason for all my problems.

It was just a bad memory modul. Believe me, i'd tested them before
carefully.
But i had to learn that even ECC-modules installed in brand motherboards
dont tell you that they are not working correctly.

After trying all new kernel versions and patches i was really
desperated.
All the discussions in the LKLM concerning the new vm +swap
frustated me since i was really thinking that the stable kernel tree is
not really stable.
I'm a user of linux since 0.99pl2 so this would have been a new
experience to me.

All in all i'm still wondering that the system was working anyway.
So finding the real error was just inspiration and luck.

Thanx for all hints

	Klaus

Stephan von Krawczynski wrote:
> 
> On Tue, 15 Jan 2002 17:42:36 +0100
> Klaus Meyer <k.meyer@m3its.de> wrote:
> 
> > As I just took a look on the output of cat /proc/meminfo i got the idea
> > that i'll increase the pysical swap space. (136M before that means >
> > highmem).
> > astonishing (using Suse kernel 2.4.16): after an increase to 2GB swap
> > and
> > using 1,5GB of mem the system runs quit a longer time with a good
> > performance,
> > but starting the copy process leads also to a slow down of the machine.
> > Finally i could see that kupdated is suffering.
> 
> I was already tempted to suggest you turn off swap completely, as 136 MB in a 2
> GB box are somehow useless anyways. I know, I have the same setup (256MB swap).
> As this could work without boot, willing to give it a try? Anyway I would very
> much suggest to use -pre3.
> 
> Regards,
> Stephan
