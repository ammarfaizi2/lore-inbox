Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318819AbSG0Uhm>; Sat, 27 Jul 2002 16:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318820AbSG0Uhl>; Sat, 27 Jul 2002 16:37:41 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:51678 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318819AbSG0Uhl>; Sat, 27 Jul 2002 16:37:41 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Rik van Riel" <riel@conectiva.com.br>,
       "Ville Herva" <vherva@niksula.hut.fi>
Cc: "DervishD" <raul@pleyades.net>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sat, 27 Jul 2002 13:41:49 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECGEPDCPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44L.0207271246040.3086-100000@imladris.surriel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Much more.
>
>The latency difference seems to be on the order of 100000 times.
>It is the latency we care about because that determines how long
>the CPU cannot do anything useful but has to wait.
>
>Rik


And if you look at the ratio between the access time of ram
which is in the low nanoseconds (1* 10 ^ -9) (data and address must be
present for at least
the rated number of ns to guarantee a sucessful read or write). and compare
it to
the seek + rotational delay of a discrete spindal which is in low
milliseconds (1* 10 ^ -3) that puts you at
a ratio of about 1000000.

regards,

--Buddy

