Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSKUFdS>; Thu, 21 Nov 2002 00:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSKUFdS>; Thu, 21 Nov 2002 00:33:18 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:273 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S263256AbSKUFdR>; Thu, 21 Nov 2002 00:33:17 -0500
Date: Thu, 21 Nov 2002 03:40:17 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/core: export sk_send_sigurg, its needed by x25 when built as a module
Message-ID: <20021121054017.GP28717@conectiva.com.br>
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

	Now there is just this outstanding changeset.

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.922, 2002-11-21 03:17:14-02:00, acme@conectiva.com.br
  net/core: export sk_send_sigurg, its needed by x25 when built as a module


 netsyms.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/net/netsyms.c b/net/netsyms.c
--- a/net/netsyms.c	Thu Nov 21 03:38:18 2002
+++ b/net/netsyms.c	Thu Nov 21 03:38:18 2002
@@ -116,6 +116,7 @@
 EXPORT_SYMBOL(sock_recvmsg);
 EXPORT_SYMBOL(sk_alloc);
 EXPORT_SYMBOL(sk_free);
+EXPORT_SYMBOL(sk_send_sigurg);
 EXPORT_SYMBOL(sock_wake_async);
 EXPORT_SYMBOL(sock_alloc_send_skb);
 EXPORT_SYMBOL(sock_alloc_send_pskb);

===================================================================


This BitKeeper patch contains the following changesets:
1.922
## Wrapped with gzip_uu ##


begin 664 bkpatch2804
M'XL(`$IQW#T``]U476_3,!1]KG_%E?8"8DE\G>^@HM(Q`=I0JXY)\%2YCMM4
M;>+)=KH5Y<?/+=)*4<7$Q!/^>O"]/C[W^,AG<&ND+GI<U)*<P2=E;-$3JI'"
M+C?<%ZKV9]H%)DJY0%"I6@;#JZ"1UF-^3%QDS*VH8".U*7KHAT\[=GLGB][D
M\N/M]?L)(?T^7%2\6<@;::'?)U;I#5^79L!MM5:-;S5O3"WM_L[N*;5CE#+7
M8TQ#&B<=)C1*.X$E(H]0EI1%61(=T'8$_XB%R'9+1O..17F6DP^`?LX84!8@
M!@R!A@6F!48>906EL%-F\+LB\`;!HV0(_[:,"R+`21L(I64!\N%.:0MF-36R
M*:=FN6CUXAR6UK@D6<H29EMX8#'<5[*!6;M<6^`&.-2J;->27`&+D:5D?%">
M>'_9"*&<DG?/U+GC[*;9UL87O]::QVE'0Z1IQQF=)0F?2SIC\[D(3^MZ`LD]
M&#JL!&D7Y1'+]E8Z2GO>3B_@1U;M#W=D4!OF+QOM<^'K]B0]S%@88NSH)6F8
M[/T4YL=V2@JD_X&=?NH_`D_?[X>SQ_CX*5[@K\].0$!R^6T\FGR=WGS_,AQ=
>OSHF^?KMX:,1E10KT]9])F0<AS0CC\D`*K3#!```
`
end
