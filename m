Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSKOIKW>; Fri, 15 Nov 2002 03:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKOIJh>; Fri, 15 Nov 2002 03:09:37 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:55425 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265898AbSKOIID>;
	Fri, 15 Nov 2002 03:08:03 -0500
Date: Fri, 15 Nov 2002 09:14:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - fix typo in amikbd.c [9/13]
Message-ID: <20021115091448.H16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz> <20021115091247.E16779@ucw.cz> <20021115091347.F16779@ucw.cz> <20021115091422.G16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091422.G16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:14:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.786.54.6, 2002-10-28 22:45:52+01:00, geert@linux-m68k.org
  Fix dyslexia in Amiga keyboard driver


 amikbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
--- a/drivers/input/keyboard/amikbd.c	Fri Nov 15 08:30:57 2002
+++ b/drivers/input/keyboard/amikbd.c	Fri Nov 15 08:30:57 2002
@@ -112,7 +112,7 @@
 	if (!request_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100, "amikeyb"))
 		return -EBUSY;
 
-	init_input_dev(&amibkd_dev);
+	init_input_dev(&amikbd_dev);
 
 	amikbd_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
 	amikbd_dev.keycode = amikbd_keycode;

===================================================================

This BitKeeper patch contains the following changesets:
1.786.54.6
## Wrapped with gzip_uu ##


begin 664 bkpatch16350
M'XL(`+&BU#T``\64;VO;,!#&7T>?XJ`P-DKL.\ER-(^,=.VZE0X6,OJZ*+86
M:XGM8BO_AC_\E#AMH1ND&QNS#;:LN_-SS_WP"=PTIDYZJ^J;,VG.3N!CU;BD
MURP;$Z3?_7I257X=YE5APD-4.)V'MKQ;.N;WQ]JE.:Q,W20]"L3#&[>],TEO
M\O[#S:>S"6/#(9SGNIR9+\;!<,A<5:_T(FM&VN6+J@Q<K<NF,$X':56T#Z$M
M1^3^E#00*..68HP&;4H9D8[(9,@C%4?L(&QTD/TDGWP4^6SYNN6"DV070,%`
MQ8&,@AB0AX0A5\!Y$LE$\E.D!!%FQM1NM+#E<M,O8C4/JGH&IP1]9._@[\H_
M9RE<V@UDVV9A-E:#+>&LL#,-<[.=5KK.(*NM]YA=`Q<Q$AL_NLGZOWDPAAK9
M6[@WS:WMPLYR%RS3]<Z\[E---^+P7D&H"SN?9D':]31`00)5A"VA$+(5`M$,
M2!@52Y31+]U[5F4_+,4IDI%JA?2N[=$YDK@#ZE]V\Q-?SVL$E:?.USTTLJ?N
M*6Z1.H8;_5?<.NF?H5^O]Y?'9WQL'']`Y`61!&)7W:UG2^MN]]5O,[-Z^:*K
>O'M^]>;QIY/F)ITWRV+(LXRD5%_9#UW-\W+/!```
`
end
