Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136738AbREJPfF>; Thu, 10 May 2001 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136740AbREJPez>; Thu, 10 May 2001 11:34:55 -0400
Received: from smtp-rt-13.wanadoo.fr ([193.252.19.223]:9872 "EHLO
	oxera.wanadoo.fr") by vger.kernel.org with ESMTP id <S136738AbREJPes>;
	Thu, 10 May 2001 11:34:48 -0400
Message-ID: <3AFAAFE1.DEA0DA6D@wanadoo.fr>
Date: Thu, 10 May 2001 17:12:33 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: twaugh@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.xx ? messages related to parport printer ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

>> May  9 13:14:59 debian-f5ibh kernel: parport0: Unspecified, EPSON
Styl

>Huh.  Does it do the same thing every time you load parport_probe?
>Does it always get truncated in the same place?

Yes ! :-/

[jean-luc@debian-f5ibh] ~ # modprobe parport_probe
parport0: PC-style at 0x378 (0x778), irq 7 [SPP,ECP,ECPEPP,ECPPS2]
parport0: Unspecified, EPSON Styl

>> With 2.4.4-ac6 and 2.4.xx, I get :
>> ----------------------------------
>> May  9 14:19:44 debian-f5ibh kernel: parport0: Printer, EPSON Stylus
>> COLOR 500

>Well, at least it seems to work in 2.4.x.

>I wonder what deviceid makes of it:

><URL:ftp://people.redhat.com/twaugh/parport/deviceid-0.3.tar.gz>

[jean-luc@debian-f5ibh] ~ # deviceid --base 0x378
MFG:EPSON;CMD:ESCPL2-00;MDL:Stylus COLOR 500;CLS:PRINTER;

There is an other strange thing : escputil expect "Stylus Color" and
my printer send "Stylus COLOR" (uppercase)...
---------
Regards
                Jean-Luc


