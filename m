Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbULVNkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbULVNkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 08:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbULVNkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 08:40:19 -0500
Received: from [62.206.217.67] ([62.206.217.67]:48330 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261774AbULVNkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 08:40:12 -0500
Message-ID: <41C97915.8020604@trash.net>
Date: Wed, 22 Dec 2004 14:39:33 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: davem@davemloft.net
CC: 7atbggg02@sneakemail.com, linux-kernel@vger.kernel.org,
       solt2@dns.toxicfilms.tv, yoshfuji@linux-ipv6.org
Subject: Re: what/where is ss tool ?
References: <012f01c4e81f$f4bddbd0$0e25fe0a@pysiak>	<20041222122758.GB6627@m.safari.iki.fi>	<41C96F24.2050409@trash.net> <20041222.222654.126619836.yoshfuji@linux-ipv6.org>
In-Reply-To: <20041222.222654.126619836.yoshfuji@linux-ipv6.org>
Content-Type: multipart/mixed;
 boundary="------------000600040909010407000804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000600040909010407000804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

YOSHIFUJI wrote:
> would you enclose URL by <>, like <http://...>?
> 
> --yoshfuji
> 

Updated patch attached, thanks everyone.


--------------000600040909010407000804
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

===== net/ipv4/Kconfig 1.23 vs edited =====
--- 1.23/net/ipv4/Kconfig	2004-11-03 21:20:02 +01:00
+++ edited/net/ipv4/Kconfig	2004-12-22 14:37:55 +01:00
@@ -355,7 +355,10 @@
 	default y
 	---help---
 	  Support for TCP socket monitoring interface used by native Linux
-	  tools such as ss.
+	  tools such as ss. ss is included in iproute2, currently downloadable
+	  at <http://developer.osdl.org/dev/iproute2>. If you want IPv6 support
+	  and have selected IPv6 as a module, you need to build this as a
+	  module too.
 	  
 	  If unsure, say Y.
 

--------------000600040909010407000804--
