Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbRFCXY0>; Sun, 3 Jun 2001 19:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263751AbRFCVKI>; Sun, 3 Jun 2001 17:10:08 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:30187 "EHLO
	iron.vbnet.com.br") by vger.kernel.org with ESMTP
	id <S262693AbRFCVJz>; Sun, 3 Jun 2001 17:09:55 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_C6KDL45FMMLCSMMPPM30"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 245-ac7 i2c Config.in fix
Date: Sun, 3 Jun 2001 18:08:36 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060318083600.25690@shark.techlinux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C6KDL45FMMLCSMMPPM30
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

- --- drivers/i2c/Config.in~	Sun Jun  3 12:34:07 2001
+++ drivers/i2c/Config.in	Sun Jun  3 18:01:53 2001
@@ -31,7 +31,7 @@
     tristate '  Intel 82371AB PIIX4(E)' CONFIG_I2C_PIIX4
     dep_tristate '  VIA Technologies, Inc. VT82C586B' CONFIG_I2C_VIA $CONFIG_I2C_ALGOBIT
     tristate '  VIA Technologies, Inc. VT596A/B' CONFIG_I2C_VIAPRO
- -    dep_tristate '  Voodoo3 I2C interface' CONFIG_I2C_VOODOO $CONFIG_I2C_ALGOBIT
+    dep_tristate '  Voodoo3 I2C interface' CONFIG_I2C_VOODOO3 $CONFIG_I2C_ALGOBIT
     tristate '  Pseudo ISA adapter (for hardware sensors modules)' CONFIG_I2C_ISA 
   fi
- -- 

cya;
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQIXAwUBOxq1bRfQA3nqPEsZFANusAf/Xj2To5GBWmSAUTvpMbh1rGNse5h8eoE6
cN2c3ljUFmv3UrTmqrL1e4HgIdEmJzCp12BerhmYOuoKDa4zHsPLGFRq2d3DNAj+
3EDlvnWCXmKlRelTDOFQMt/4wD7BqUqUrnQim4b3maeIR0ZJ3EUhGSeVTyKnzUWv
/eJXHtNfyCC/D1Xz36/af54CPF3nPjSKo5kvFgCQSW7xNQOKOS6mS0dQcouC2BLz
C77fpYRkBykbtksajVfEHLo6eRbGdEquerOWAVCsyWs7FAAmoG6xn95UXdLTw9Xz
iFSr29CX+gxNBoEnu+1PqoVxKmi0h4K8isgvXWMwIp7XnWgS+gFZRwgAhsyx2ISi
CcUtRTPcRYh75PxruxwdbBW2dTu1C+T0g0XgN86yvp2hNPSoSDtCn9PmzTRNwqzM
rD9Ew7jT+LNVFp+5MTSO4MMXeZWilBJXYMTwjoUEo5DFPgC2CmtyEw0zydVke4t6
IjlpXujH77L2M5YmYfwf8EhcEILBZXh2T8PCWjwOD/YE4OnqoW4Y0TktbRpLc669
QnHTwK1wXDmXhZX5O3izF4CpVFjSVDY0YKMzFhuAbLlA95WQ4F/kSiG8pbz9VjhC
BcHu2DUkt8CDGJ/uCNDtkrdp1eD4Ns3QazExspB22Sq0S03vxwuVQdYMzZ+6/nX0
PmWlm3nNAwAimA==
=2Q2o
-----END PGP SIGNATURE-----

--------------Boundary-00=_C6KDL45FMMLCSMMPPM30
Content-Type: text/plain;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="diff"

LS0tIGRyaXZlcnMvaTJjL0NvbmZpZy5pbn4JU3VuIEp1biAgMyAxMjozNDowNyAyMDAxCisrKyBk
cml2ZXJzL2kyYy9Db25maWcuaW4JU3VuIEp1biAgMyAxODowMTo1MyAyMDAxCkBAIC0zMSw3ICsz
MSw3IEBACiAgICAgdHJpc3RhdGUgJyAgSW50ZWwgODIzNzFBQiBQSUlYNChFKScgQ09ORklHX0ky
Q19QSUlYNAogICAgIGRlcF90cmlzdGF0ZSAnICBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODJD
NTg2QicgQ09ORklHX0kyQ19WSUEgJENPTkZJR19JMkNfQUxHT0JJVAogICAgIHRyaXN0YXRlICcg
IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ1OTZBL0InIENPTkZJR19JMkNfVklBUFJPCi0gICAg
ZGVwX3RyaXN0YXRlICcgIFZvb2RvbzMgSTJDIGludGVyZmFjZScgQ09ORklHX0kyQ19WT09ET08g
JENPTkZJR19JMkNfQUxHT0JJVAorICAgIGRlcF90cmlzdGF0ZSAnICBWb29kb28zIEkyQyBpbnRl
cmZhY2UnIENPTkZJR19JMkNfVk9PRE9PMyAkQ09ORklHX0kyQ19BTEdPQklUCiAgICAgdHJpc3Rh
dGUgJyAgUHNldWRvIElTQSBhZGFwdGVyIChmb3IgaGFyZHdhcmUgc2Vuc29ycyBtb2R1bGVzKScg
Q09ORklHX0kyQ19JU0EgCiAgIGZpCiAK

--------------Boundary-00=_C6KDL45FMMLCSMMPPM30--
