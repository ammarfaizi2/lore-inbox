Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286212AbRLaEHV>; Sun, 30 Dec 2001 23:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286217AbRLaEHL>; Sun, 30 Dec 2001 23:07:11 -0500
Received: from pool-141-154-202-101.bos.east.verizon.net ([141.154.202.101]:13064
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286212AbRLaEG7>; Sun, 30 Dec 2001 23:06:59 -0500
To: Andris Pavenis <pavenis@latnet.lv>
Cc: Doug Ledford <dledford@redhat.com>, Nathan Bryant <nbryant@optonline.net>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio driver version 0.13 still broken
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06>
	<200112080945.fB89jAC00998@hal.astr.lu.lv>
	<3C15566B.7010803@redhat.com>
	<200112271110.fBRBA5S00309@hal.astr.lu.lv>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: 30 Dec 2001 23:06:54 -0500
In-Reply-To: <200112271110.fBRBA5S00309@hal.astr.lu.lv> (Andris Pavenis's message of "Thu, 27 Dec 2001 13:10:05 +0200")
Message-ID: <m34rm8m3s1.fsf@localhost.localdomain>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis <pavenis@latnet.lv> writes:

> Now returned in Riga and tested i810_audio driver version 0.13 from 
> 	http://people.redhat.com/dledford/i810_audio.c.gz
> with kernel 2.4.17
> 
> It still hanged machine after playing KDE startup sound. Didn't tried much 
> more and moved to my modified version of 0.12 which worked
> 
> With best regards
> 
> Andris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Doug's 0.12 driver fixed my problems.  ESD would not detect my audio
device if I loaded i810_audio after XF86.

-- 
Nick
