Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129434AbQKYOPk>; Sat, 25 Nov 2000 09:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129437AbQKYOPV>; Sat, 25 Nov 2000 09:15:21 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:53778 "EHLO
        sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
        id <S129434AbQKYOPO>; Sat, 25 Nov 2000 09:15:14 -0500
Date: Sat, 25 Nov 2000 13:44:37 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: LKCD from SGI
In-Reply-To: <20001125141830.C2877@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10011251341460.878-200000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1388574315-2080741805-975159877=:878"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1388574315-2080741805-975159877=:878
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 25 Nov 2000, J . A . Magallon wrote:

> Could the default target install names int the std kernel be changed to 
> System.map -> System.map-$(KERNELRELEASE)
> vmlinuz    -> vmlinuz-$(KERNELRELEASE)
> and then symlink to that ?
>
> I think everyone that has a stable2.2, a devel 2.2 and a test24 is
> using that method, so as many distros...

The /sbin/installkernel hooks allow you to do this (and
other stuff) very easily:

# make install

does it all for you on Red Hat.  I've attached their
/sbin/installkernel in case you want to see how its
done.

Matthew.

--1388574315-2080741805-975159877=:878
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=installkernel
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10011251344370.878@sphinx.mythic-beasts.com>
Content-Description: 
Content-Disposition: attachment; filename=installkernel

IyEgL2Jpbi9zaA0KDQojDQojIC9zYmluL2luc3RhbGxrZXJuZWwgIC0gd3Jp
dHRlbiBieSB0eXNvbkByd2lpLmNvbQ0KIw0KDQpJTlNUQUxMX1BBVEg9L2Jv
b3QNCg0KS0VSTkVMX1ZFUlNJT049JDENCkJPT1RJTUFHRT0kMg0KTUFQRklM
RT0kMw0KDQppZiBbIC1mICRJTlNUQUxMX1BBVEgvdm1saW51ei0kS0VSTkVM
X1ZFUlNJT04gXTsgdGhlbiANCiAgICAgIG12ICRJTlNUQUxMX1BBVEgvdm1s
aW51ei0kS0VSTkVMX1ZFUlNJT04gXA0KICAgICAgICAgICAgICAkSU5TVEFM
TF9QQVRIL3ZtbGludXoub2xkOw0KZmkNCg0KaWYgWyAtZiAkSU5TVEFMTF9Q
QVRIL1N5c3RlbS5tYXAtJEtFUk5FTF9WRVJTSU9OIF07IHRoZW4gDQogICAg
ICBtdiAkSU5TVEFMTF9QQVRIL1N5c3RlbS5tYXAtJEtFUk5FTF9WRVJTSU9O
IFwNCiAgICAgICAgICAgICAgJElOU1RBTExfUEFUSC9TeXN0ZW0ubWFwLm9s
ZDsgDQpmaQ0KDQpjYXQgJEJPT1RJTUFHRSA+ICRJTlNUQUxMX1BBVEgvdm1s
aW51ei0kS0VSTkVMX1ZFUlNJT04NCmNwICRNQVBGSUxFICRJTlNUQUxMX1BB
VEgvU3lzdGVtLm1hcC0kS0VSTkVMX1ZFUlNJT04NCg0KbG4gLWZzIHZtbGlu
dXotJEtFUk5FTF9WRVJTSU9OICRJTlNUQUxMX1BBVEgvdm1saW51eg0KbG4g
LWZzIFN5c3RlbS5tYXAtJEtFUk5FTF9WRVJTSU9OICRJTlNUQUxMX1BBVEgv
U3lzdGVtLm1hcA0KDQppZiBbIC14IC9zYmluL2xpbG8gXTsgdGhlbiAvc2Jp
bi9saWxvOyBlbHNlIC9ldGMvbGlsby9pbnN0YWxsOyBmaQ0KDQo=
--1388574315-2080741805-975159877=:878--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
