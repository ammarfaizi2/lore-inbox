Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130953AbRCMHrC>; Tue, 13 Mar 2001 02:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130958AbRCMHqx>; Tue, 13 Mar 2001 02:46:53 -0500
Received: from mail.veka.com ([213.68.6.130]:27600 "EHLO veka.com")
	by vger.kernel.org with ESMTP id <S130953AbRCMHqp>;
	Tue, 13 Mar 2001 02:46:45 -0500
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_PNL4ZLP9YGSHDBW13I74"
From: Frank Fiene <frank.fiene@syntags.de>
Organization: Syntags GmbH
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Fwd: Re: patch-2.4.2-ac19
Date: Tue, 13 Mar 2001 08:47:49 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01031308474902.02849@fflaptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_PNL4ZLP9YGSHDBW13I74
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit



----------  Forwarded Message  ----------
Subject: Re: patch-2.4.2-ac19
Date: Tue, 13 Mar 2001 08:46:22 +0100
From: Frank Fiene <frank.fiene@syntags.de>
To: Joachim Backes <backes@rhrk.uni-kl.de>


On Tuesday, 13. March 2001 08:14, Joachim Backes wrote:
> Hi,
>
> after applying patch-2.4.2-ac19 to the base 2.4.2 distribution, I
> have problems to install vmware: the vmware install has problems to
> find the symbol
>
>                 skb_datarefp
>
> in the /usr/src/linux/include tree.
>
> Without applying patch-2.4.2-ac19, it is found in
>
>                 /usr/src/linux/include/linux/skbuff.h
>
> and vmware-2.0.3-799 can be compiled.

Here is a patch for vmware. You have to apply this on
vmware-distrib/lib/modules/source/vmnet.tar:
untar vmnet
apply patch to vnetInt.h
tar vmnet
install

Regards. Frank.
P.S.: This is not official. It works for me!
--
Frank Fiene, SYNTAGS GmbH, Im Defdahl 5-10, D-44141 Dortmund, Germany
Security, Cryptography, Networks, Software Development
http://www.syntags.de mailto:Frank.Fiene@syntags.de

-------------------------------------------------------

-- 
Frank Fiene, SYNTAGS GmbH, Im Defdahl 5-10, D-44141 Dortmund, Germany
Security, Cryptography, Networks, Software Development
http://www.syntags.de mailto:Frank.Fiene@syntags.de

--------------Boundary-00=_PNL4ZLP9YGSHDBW13I74
Content-Type: application/x-bzip2;
  charset="iso-8859-1";
  name="vmware.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="vmware.patch.bz2"

QlpoOTFBWSZTWSTARa8AAFL/gFQUBABJb3+zfy+/RL/v3yAwARrTMNJqaT0mmQeoAAABoBo0009R
oAammpHqPUyNGmjTE0AAADQNBoaCSimaSepmkxNM9RMmAQ0YTTMkNNG0HAafGkDazBkAAUZO5xLM
1VEORduUu+4WX/JGRSjAgmhaCyDoDyFrSQbKuIrCT8+dWikaU34dN1XrAbKxmwyNJCJ0FVnsfraj
hCngVCBH0X24MoZAVpW2YvEBonA0KGAOkIBBjE0TizA1s5FEcTYjEnMJ6NKNxQcEdoSE0jr22M4C
R9txCN6jeKYO9AkpAoP7AyYhAl0iGAxBOqgSg/ICihTbtehcSMritxImYo3k6kQwlhKBCk0YSU/4
cRKdlOZG4hEqHKd6sLtExPGl8jHPyjVUgOlp8jaAeQ065NWExLWQRKmUPiiGUBiIwkOfxdyRThQk
CTARa8A=

--------------Boundary-00=_PNL4ZLP9YGSHDBW13I74--
