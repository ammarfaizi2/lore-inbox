Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbTCTQXB>; Thu, 20 Mar 2003 11:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTCTQXA>; Thu, 20 Mar 2003 11:23:00 -0500
Received: from mario.gams.at ([194.42.96.10]:26906 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S261505AbTCTQW7> convert rfc822-to-8bit;
	Thu, 20 Mar 2003 11:22:59 -0500
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: Srihari Vijayaraghavan <harisri@bigpond.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bottleneck on /dev/null 
References: <Pine.LNX.4.33.0303201720170.8831-100000@gans.physik3.uni-rostock.de> 
In-reply-to: Your message of "Thu, 20 Mar 2003 17:21:10 +0100."
             <Pine.LNX.4.33.0303201720170.8831-100000@gans.physik3.uni-rostock.de> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 20 Mar 2003 17:33:32 +0100
Message-ID: <28588.1048178012@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>On Thu, 20 Mar 2003, Richard B. Johnson wrote:
>
>> unsigned long amount = 0L;
>
>try 'volatile' to get the deviation down...

.. and try "long long" to avoid an overrun.

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


