Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSDQPwQ>; Wed, 17 Apr 2002 11:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSDQPwP>; Wed, 17 Apr 2002 11:52:15 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:9672 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292666AbSDQPwN>; Wed, 17 Apr 2002 11:52:13 -0400
Date: Wed, 17 Apr 2002 17:52:09 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [BKPATCH 2.4] sonypi driver: doclet fix.
Message-ID: <20020417155209.GC1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a trivial doclet in the sonypi driver,
reported by Christoph Begall.

Marcelo, please apply.

Stelan.

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.418, 2002-04-17 15:59:55+02:00, stelian@popies.net
  Doclet for sonypi driver, as reported by Christoph Begall.


 sonypi.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/sonypi.txt b/Documentation/sonypi.txt
--- a/Documentation/sonypi.txt	Wed Apr 17 16:00:17 2002
+++ b/Documentation/sonypi.txt	Wed Apr 17 16:00:17 2002
@@ -36,14 +36,14 @@
 driver and the ACPI BIOS, because Sony doesn't agree to release any programming
 specs for its laptops. If someone convinces them to do so, drop me a note.
 
-Module options:
+Driver options:
 ---------------
 
 Several options can be passed to the sonypi driver, either by adding them
 to /etc/modules.conf file, when the driver is compiled as a module or by
 adding the following to the kernel command line (in your bootloader):
 
-	sonypi=minor[[[[[,camera],fnkeyinit],verbose],compat],nojogdial]
+	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,nojogdial]]]]]
 
 where:
 

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch14465
M'XL(`/%_O3P``[54T6K;,!1]CK[B0A^;V)(MV[$A(VLSMK'!0D:?PAX468FU
MV)*1E"X&?_SD9#1C:S<Z5ME<P_75T3WG'G0%=U:88F2=J"53Z`K>:>N*4:M;
M*6R@A/.IE=8^%5:Z$:&32NI#N!=&B3JLI3H<)U%`D2];,L<KN!?&%B,2Q`\9
MU[6B&*W>O+W[^'J%T&P&MQ53._%9.)C-D-/FGM6EG3-7U5H%SC!E&^%8P'73
M/Y3V$<:1?Q*2Q3A)>Y)BFO6<E(0P2D2)(SI-*6J8X:+6\[8^\'T7E-(ZHSV2
M$MS)>_8K'AU@HBG.^P3'TRE:``DHF0*.0DQ#D@%)BB0ODN0:1P7&\$.G^44?
MN"8PP>@&_B^/6\1AH7GM#]AJ`U:KKI50&NGU'0.S8$2KC1,E;#JOI_$\=5O!
MC=BQN@[0!T@PQ1@M+UJCR3,70IAA]`K:88J/L_(='AJA''-2J_#<9."./Y',
M"8Y)3W&2T9YSZK4EFZ@D.:,L?T3-OR!2DI$XR1/2IPG-Z,E,3^T8O/5BK:/G
MM^[!B/=:.K2>GIWVN\_('WP6P21Z$9]MY=$/V3`/(@QH4_K(5`FV\V2.WDMG
ML3_!Q'P[O=X;RR=U_P>?+>(<"'I_BHN3Q4&W`ZPMT(*FP[]3')U/F352:;,>
M^[J-MF(]WJJ]Z/S%Y-9C[ED8YK^Z\<-?CY7^JG>E9/6785VN*5X)OK>'9L9$
.F:9EE*/O?F0NZ@L%````
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
