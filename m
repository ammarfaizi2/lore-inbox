Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272072AbRIEK1x>; Wed, 5 Sep 2001 06:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272071AbRIEK1o>; Wed, 5 Sep 2001 06:27:44 -0400
Received: from gtDEI-NATgw.dei.uc.pt ([193.137.203.232]:2055 "EHLO
	eden.dei.uc.pt") by vger.kernel.org with ESMTP id <S272074AbRIEK1g>;
	Wed, 5 Sep 2001 06:27:36 -0400
Message-Id: <200109051027.f85ARmM10012@polaris.dei.uc.pt>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Antonio Miguel Trindade <trindade@dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors
Date: Wed, 5 Sep 2001 11:27:47 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int> <3B95DB22.866EDCA3@mediascape.de> <3B95EA8F.93B27304@t-online.de>
In-Reply-To: <3B95EA8F.93B27304@t-online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Quarta 05 Setembro 2001 10:04, Frank Schneider escreveu:
> Olaf Zaplinski schrieb:
>
> I had this effect too here (RH7.1, Kernel 2.4.3), but i put it on a
> wrong termination of the LVD Bus...be careful if you have LVD-Drives
> with a "Termination"-Jumper...(e.g. IBM DGHS18V)...this Termination is
> only usable if you use the drive as Single Ended SCSI-UW, *not* if you
> use the drive i a true LVD-environment !
>
> I learnt this the hard way, because i used this "Termination"-jumper and
> the system bootet without problems and ran about 2 weeks...then the
> above errors occured, followed by system crashes....after reading the
> original ibm-docs, and not the oem-reseller-crap, the reason was clear.
>

   According to IBM specs, _no LVD drive has terminators built-in_... I have 
several servers with LVD drives (all IBM) and none of them has terminators, 
even in SE mode. You always have to use an external terminator...

>
> Solong..
> Frank.

-- 
A year spent in artificial intelligence
is enough to make one believe in God.

    -------------------------------
     António Miguel F. M. Trindade
        System's Administrator
           D.E.I. F.C.T.U.C.
    -------------------------------
