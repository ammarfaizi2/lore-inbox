Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312410AbSCUReJ>; Thu, 21 Mar 2002 12:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312422AbSCURcL>; Thu, 21 Mar 2002 12:32:11 -0500
Received: from venus.ci.uw.edu.pl ([193.0.74.207]:12302 "EHLO
	venus.ci.uw.edu.pl") by vger.kernel.org with ESMTP
	id <S312398AbSCURbu>; Thu, 21 Mar 2002 12:31:50 -0500
Date: Thu, 21 Mar 2002 18:27:17 +0100
From: Michal Dorocinski <zwierzak@venus.ci.uw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: sis 5591 ide in 2.4.19-pre3 consumes souls
Message-ID: <20020321182717.K806@venus.ci.uw.edu.pl>
In-Reply-To: <3C9A0C22.3090702@inet6.fr> <20020321171851.A0D29A3C21@fancypants.trellisinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <3C9A0C22.3090702@inet6.fr> you wrote:
> > There's definitely a problem with some UDMA 33 chipsets. I'll ask SiS 
> > for 5591 chipset info RSN and look into this as soon as I find some time.
> 
> i look forward to it :).  in light of this problem (i've recieved mail from
> one michal dorocinski echoing this behavior and referencing an -ac patch; i've
> asked him to mail it here), will this driver stay in .19 for the time being?
> 
Yes.
As I found it in -pre3 the result was: timeouts and some debugs (Lionel has the
log) and no partition table was found (BadCRC messages from hda). It worked
then after a day or two when -ac1 or -ac2 was found so I think it was solved.
I will check -pre4 if it work.

Btw. I have a question... will an SiS 6326 AGP will be supported anyhow by agp
gart ? It is supported by Xfree driver but no xv nor AGP or dri acceleration
as I can see is realy used. It also has some wired problems with colorded dots
(blue and red).
But this is maybe a subject to AGP/SiS VGA/XFREE drivers maintaners :)

Greetings

	Zwierz

-- 
The Shadow, The Darkness, The Fear...
	Forever Alone Immortal...
