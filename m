Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSKYBUz>; Sun, 24 Nov 2002 20:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSKYBUz>; Sun, 24 Nov 2002 20:20:55 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:32273 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262258AbSKYBUy>; Sun, 24 Nov 2002 20:20:54 -0500
Date: Sun, 24 Nov 2002 23:27:59 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/ipv4/af_inet.c: remove include seq_file.h and proc_fs.h, not needed anymore
Message-ID: <20021125012759.GX31074@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	Now there are six outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.863, 2002-11-24 23:15:52-02:00, acme@conectiva.com.br
  o net/ipv4/af_inet.c: remove include seq_file.h and proc_fs.h, not needed anymore
  
  thanks to Chris Wilson <chris@qwirx.com> for pointing out that seq_file.h
  was not needed anymore.


 af_inet.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Sun Nov 24 23:16:16 2002
+++ b/net/ipv4/af_inet.c	Sun Nov 24 23:16:16 2002
@@ -103,8 +103,6 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <linux/skbuff.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <net/sock.h>
 #include <net/raw.h>
 #include <net/icmp.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.863
## Wrapped with gzip_uu ##


begin 664 bkpatch30696
M'XL(`.!YX3T``^V446O;,!#'GZ-/<=#'+;9.EI38+"5K.S;H8"&C[#$HLE*;
MQE8J*<D*_O!3,FA+FJRL['&27N23__?7W0^=P8TWKN@IW1AR!E^L#T5/V];H
M4&]4HFV3S%T,3*V-@;2RC4DOKM/6A#Y+!(F1B0JZ@HUQONAADCU^"0\K4_2F
MGS[??/TX)60T@LM*M;?FNPDP&I%@W48M2S]6H5K:-@E.M;XQ89^S>SS:,4I9
MG`('&16R0TGYH--8(BJ.IJ2,#R4G._OC0]L'*HB,LPR19IW`+)?D"C`9R@PH
M2Q%3QH%E!8I"L#YE!:5P5!3>(?0IN8!_>X%+HL%"+&M:KS8\58M9'3>)+L"9
MQFX,U*U>KDL#WMS/%O72)!6HMH25LWJV\$GU'EH;HH`I31DC#XUU)FK&%:*5
M.Q_]Q@:XVL./>NEM"Q_T;C>^W];NY\[R.2RL@Y6MVU"WMV#78?=G>)8P:FV5
M/Y(G(=<@,!:73)Z:3/I_.0BABI+S5PK[LD3/*YR+8<?$$+-N(+&40N9LGG%-
M]?!X-T_)158$110\[R25@WS/[\NSKX/\5KLGB#YMEU/D.:,=I1C[L$,[DX=D
M\_S/9%/HL_]D'Y+]&X!OT'?;_8JD3H[<YPV\7R&5P)X>45T9?>?7S0@'<\Q+
+Q<DO/<$PYI\%````
`
end
