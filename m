Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRHaWpw>; Fri, 31 Aug 2001 18:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRHaWpn>; Fri, 31 Aug 2001 18:45:43 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:3084 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S269646AbRHaWpa>;
	Fri, 31 Aug 2001 18:45:30 -0400
Message-ID: <3B9013E3.1010005@si.rr.com>
Date: Fri, 31 Aug 2001 18:46:59 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH]2.4.9-ac5: drivers/net/bagetlance.c 
Content-Type: multipart/mixed;
 boundary="------------090406060400000608090707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090406060400000608090707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
    Please test the attached patch. It addresses a FIXME within the file 
that changes CSR3_ACON from 0 to 0x0002 . This is against 2.4.9-ac5 . 
Thanks.
Regards,
Frank

--------------090406060400000608090707
Content-Type: text/plain;
 name="BAGETLANCEPATCH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BAGETLANCEPATCH"

--- drivers/net/bagetlance.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/bagetlance.c	Fri Aug 31 18:23:35 2001
@@ -321,7 +321,7 @@
 
 /* CSR3 */
 #define CSR3_BCON	0x0001		/* byte control */
-#define CSR3_ACON	0 // fixme: 0x0002		/* ALE control */
+#define CSR3_ACON	0x0002		/* ALE control */
 #define CSR3_BSWP	0x0004		/* byte swap (1=big endian) */
 
 

--------------090406060400000608090707--

