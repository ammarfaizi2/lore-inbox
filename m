Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135619AbRDSLAO>; Thu, 19 Apr 2001 07:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRDSK7y>; Thu, 19 Apr 2001 06:59:54 -0400
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:12811 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S135619AbRDSK7o>; Thu, 19 Apr 2001 06:59:44 -0400
Message-ID: <04ca01c0c8c0$c62e8f30$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: "Andreas Ferber" <aferber@techfak.uni-bielefeld.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <004901c0c74a$c50880b0$ae58718c@cis.nctu.edu.tw> <20010417163905.K4385@kallisto.sind-doof.de>
Subject: Re: icmp and port
Date: Thu, 19 Apr 2001 19:06:22 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your answer, and I still have some questions.

(private)---->(masquerade)---->(public)
If I ping public host from private host using this command:
ping 140.113.1.1
What trigger ICMP message? The "ping" binary program?
AND
How masquerade gateway know the original packet port information?
Because I think original packets are in private hosts, masquerade
gateway can't get the original packet.

If I am wrong, please feel free to advice me.
Thanks in advance.

Cheers,
Tom
----- Original Message -----
From: "Andreas Ferber" <aferber@techfak.uni-bielefeld.de>
To: "gis88530" <gis88530@cis.nctu.edu.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, April 17, 2001 10:39 PM
Subject: Re: icmp and port


> Hi,
>
> On Tue, Apr 17, 2001 at 10:28:53PM +0800, gis88530 wrote:
> >
> > Do icmp packets have port information?
>
> ICMP packets quote part of the original packet that triggered the ICMP
> message. From this quoted part, information can be extracted about the
> connection the ICMP packet belongs to.
>
> Andreas
> --
> I *____knew* I had some reason for not logging you off... If I
could just
> remember what it was.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

