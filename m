Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318804AbSHRCZm>; Sat, 17 Aug 2002 22:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318805AbSHRCZm>; Sat, 17 Aug 2002 22:25:42 -0400
Received: from imo-m02.mx.aol.com ([64.12.136.5]:5628 "EHLO imo-m02.mx.aol.com")
	by vger.kernel.org with ESMTP id <S318804AbSHRCZk>;
	Sat, 17 Aug 2002 22:25:40 -0400
Message-ID: <3D5ECEFE.4020404@netscape.net>
Date: Sat, 17 Aug 2002 22:32:30 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net> <20020817190324.GA9320@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------020804080905060905080208"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------020804080905060905080208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



greg@kroah.com wrote:

>On Sat, Aug 17, 2002 at 02:10:34PM +0000, Adam Belay wrote:
>
>>
>>greg@kroah.com wrote:
>>
>>>Um, your email client mangled the patch, dropping tabs and wrapped
>>>lines.
>>>
>>Thanks for pointing this out.  I'll send it as an attachment this time.
>> My current client has been causing me a lot of trouble, is there one
>>you would suggest I use?
>>
>
>I like mutt, but that's just my opinion :)
>
>Hm, in looking at your attachments, they will not apply either.  All the
>tabs are gone, something's wrong with your originals.  Did you cut and
>paste to generate them?
>
I downloaded my patches through the mailing list and applied them:

bash-2.05a$ cat ./driver.patch | patch -p1 -l -d linux
patching file drivers/base/interface.c
bash-2.05a$ cat ./driver2.patch | patch -p1 -l -d linux
patching file drivers/base/base.h
patching file drivers/base/core.c
patching file drivers/base/interface.c

It applies cleanly but . . .

You're right the tabs are gone although when I applied my originals they 
weren't.  I hate netscape navigator.  I gzipped them so netscape can't 
mess them up.  In the meantime I'm going to download mutt.  Thanks for 
your help.  Let me know if the patch works this time.  Also after 
looking at the interface code I realized that not just my code used 
sprintf.  Do you think they should all use snprintf instead or is the 
probability of a driver attribute exceeding the one page buffer size so 
low that it doesn't matter?

Also I was wondering if you think resource management variables (irq, 
io, dma, etc) should live in the device structure like power management 
variables do?  Global resource management seams interesting to me, 
although there already is a proc interface that does list resources, I'm 
wondering if the driver model is a good place to put such an interface?

Thanks,
-Adam



--------------020804080905060905080208
Content-Type: application/octet-stream;
 name="driver.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="driver.tar.gz"

H4sICHnLXj0AA3RlbXBfdGFyODNxR0ZiLnRhcgDtV21z2kYQ5qv0K7Z0moFIsiUBAkPsONMm
ncxk2hknbj60HY0Qp6IplpiThO2k/u/dexEIEDghsdPO3H7Qwd7t3r7cPbc7ofGC0KN5kIfT
xgOR7di21+02bNt2+j2HjYzK0XH7XsPu99y+2+902TrHdTy7AfZDGVSlIssDCtAIrsY3zp51
NE3zx7DnkWkSRxFYBQXLSsi1FcUzAsHxhJ+K7HgcZOQ4TnJCoyAkRyGMd07plmXtkdTekwm8
KP4CpwtOf2ifDN0BuLbt6oZh7FGrvaKxkPPAdYd2Z+hIufNzsAYDcwAGfl0bzs91wFzmcQg/
vfzt9Y8v/Rfv3l205uk1oWaTD03zrf/6/eXbC/gH8NfF5c+/mjpoGgBMyCIOiU9JMPGFiORc
0zgngtUe6aAbuiF3ybL4A/HzNVHhRivLaRGWM/CU/TAhnOJBewrjIjJBioZpkeQmzNIown/4
bevGR93Q4ghaKGOdCX3I1TRK8oImbBE8BxuGkM0pBipqMYXNH7I/kqZZkbHOkuCKoMmGRmYZ
qWiwkXdX8aMaLSFrNsXI48WjtO2j+cvlmzdMPYt6xVs/yHMaj4tc+s1YExIFxSz32enKfv8T
TuEjhv0JzvLVPrPUXOOIFKDRK5bcFpexnXG8G+nf+vb8/0lE1X3QB+Ae/O913E6J/z3HtRn+
ux2F/49Cn4D/7HM03cRowa1DfTFTBW7HHbr2ErhrAH9bBLEenwnXW2G965kdMPDb41CvA7nB
VyIBxEAQyhhOBOF0HX0lbjAwoguG4FJskcaTUm5C7pczqtul/h7JEu8PUFfnQKmOG4y/gzxA
+U/IW5jSmidbcOvyJmY+66GWIht584Yde5W3k4HZB4N/Rd7ksyMSUD4Qu/xu6/hWWNruWI7w
Sd43zXbcek/5+6PN0vBvX8iwWYwqs9dx+sxgMTCLtTt8a1CNJQ0/LGW6caAct3W3g/iY7ji4
bSY/Yt7jxoTSlOJaWzrZ6XIn+cCdlMXBuMj8KKU+QeNYbLAiwLAh18Qf5qb57D7tDs2Bl2Mz
Uoeq4YHbzvHWaYDTUy6A6x+tGt6oar1h1zmgGnZ6Q/ekUg2bHhbDMqHfx0k4KyYEns3ipLg5
FjE4mp5tT+HZqOWzpLIJYznRFEDdrFzjuiqY1XNfUgNjJjhy9CVydLvijFYq2LVj94UV7I5D
FMVJudQf3645xW5Jfjsn3JVs6RavuEUFLxfO4iz3p7gnzs7TbHQPVhkaFygvIGD3gtqf4B7l
Yc1YL8A20MTd5+tJktNbsbZOu8ntZSt5O8DP/3e4MAmv5uJ+8wKcf5A9I0mLewIWOG3ee5SB
F0YiB/uHkseiyJl3u3sj0UR9peZoLxZKazYxT7RUQsdaIySCwdEAg1Sd5duvr1h1Y5UM1B2T
Uh+LfLQKukA3DGdp2dZzwGIhCwQWZWCtGyzzFbOE8XaPkqt0QZqm115as61TAiePb9X+0XoC
heAz7Cmfy9/DpfOf0Sdu9tXGVl8thWrOBO+sv1Yf+a1LakWKFClSpEiRIkWKFClSpEiRIkWK
FCn6T9C/eX2jxwAoAAA=
--------------020804080905060905080208--
