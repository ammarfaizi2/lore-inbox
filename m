Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314303AbSD0R42>; Sat, 27 Apr 2002 13:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314318AbSD0R41>; Sat, 27 Apr 2002 13:56:27 -0400
Received: from kahuna.kalkatraz.de ([62.145.25.91]:15755 "EHLO
	golem.home.local") by vger.kernel.org with ESMTP id <S314303AbSD0R41>;
	Sat, 27 Apr 2002 13:56:27 -0400
Date: Sat, 27 Apr 2002 19:56:09 +0200
From: Lars Weitze <cd@kalkatraz.de>
To: linux-kernel@vger.kernel.org
Subject: 100 Mbit on slow machine
Message-Id: <20020427195609.0a397df9.cd@kalkatraz.de>
Organization: http://www.liquidsteel.net
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: "Add'HrsHhg}pA?6>_fl]8[PNFwpJTSTW?I_:}%1O}rQof)E5W:qQbr1i>J?[?W:9"~?}]; ,?}|UTr8Ww=d%HY}-ap:|nv&<Y?3}t~lcR9D/?<~c</0{]DzT-Oj[cU;XPiM\CR6FjHk)5'ztDGpD< j]qoHG:5[;Y!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using a P200 MMX as an Fileserver. After i upgraded it to an 100
Mbit/s NIC (tulip chip and 3Com "Vortex" tried) i am getting the follwing
behaviour: The network stack seems to "block" when sending files to the
machine with full 100 Mbit/s. There are -no- kernel messages. Doing a ping
an the machine gives all ping packets back in "one bunch". Even after
stopping accesing the machine at full speed (stopping the transfer) i am
just getting this "packaged" ping reply (9000 ms and more).

A ping -f -s 65000 will also lock up the machine. Doing an ifdown -a ;
ifup -a resloves the problem until the next "flood".

Regards
CD
-- 
    "Ihre Meinung ist mir zwar widerlich, aber ich werde mich
     dafuer totschlagen lassen, dass sie sie sagen duerfen."
                                                        Voltaire

PGP-Key:          http://cd.kalkatraz.de
PGP fingerprint:  4950 8576 778F DEDF 85D1  C04D 586F 2C45 E714 E13A
