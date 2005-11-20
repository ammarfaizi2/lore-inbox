Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVKTL1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVKTL1h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 06:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKTL1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 06:27:36 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61621 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751209AbVKTL1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 06:27:36 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [linux-dvb-maintainer] [PATCH] Re: bugs in /usr/src/linux/net/ipv6/mcast.c
Date: Sun, 20 Nov 2005 13:27:23 +0200
User-Agent: KMail/1.8.2
Cc: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>,
       Andrew Morton <akpm@osdl.org>, kai.germaschewski@gmx.de,
       linux-dvb-maintainer@linuxtv.org,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <0C6AA2145B810F499C69B0947DC5078107BCDE20@oh0012exch001p.cb.lucent.com> <200511171500.06910.vda@ilport.com.ua> <20051120020115.GA8157@linuxtv.org>
In-Reply-To: <20051120020115.GA8157@linuxtv.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b2FgDalRWQiBFpo"
Message-Id: <200511201327.23475.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_b2FgDalRWQiBFpo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 20 November 2005 04:01, Johannes Stezenbach wrote:
> Can you add your Signed-off-by: ?

Sure.

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_b2FgDalRWQiBFpo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.6.14.semicolon_fix.dvb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.14.semicolon_fix.dvb.diff"

diff -urpN linux-2.6.14.org/drivers/media/dvb/frontends/ves1820.c linux-2.6.14.semicolon_fix/drivers/media/dvb/frontends/ves1820.c
--- linux-2.6.14.org/drivers/media/dvb/frontends/ves1820.c	Sat Nov  5 15:17:30 2005
+++ linux-2.6.14.semicolon_fix/drivers/media/dvb/frontends/ves1820.c	Thu Nov 17 14:41:05 2005
@@ -140,25 +140,25 @@ static int ves1820_set_symbolrate(struct
 	/* yeuch! */
 	fpxin = state->config->xin * 10;
 	fptmp = fpxin; do_div(fptmp, 123);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 	fptmp = fpxin; do_div(fptmp, 160);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 0;
 	fptmp = fpxin; do_div(fptmp, 246);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 	fptmp = fpxin; do_div(fptmp, 320);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 0;
 	fptmp = fpxin; do_div(fptmp, 492);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 	fptmp = fpxin; do_div(fptmp, 640);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 0;
 	fptmp = fpxin; do_div(fptmp, 984);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 
 	fin = state->config->xin >> 4;

--Boundary-00=_b2FgDalRWQiBFpo--
