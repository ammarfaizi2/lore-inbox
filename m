Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272405AbTHIQNA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272410AbTHIQNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:13:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:909 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S272405AbTHIQM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:12:59 -0400
Date: Sat, 09 Aug 2003 12:11:27 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH][TRIVIAL 2.4]  Unused label in net/sunrpc/xdr.c
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F351D2F.7050800@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_eINmfEJFBaKaE/MDx+vycA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_eINmfEJFBaKaE/MDx+vycA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    the following patch removes an unused label in net/sunrpc/xdr.c

    The patch applies to 2.4.22-rc1-ac1.

Stephane Ouellette.


--Boundary_(ID_eINmfEJFBaKaE/MDx+vycA)
Content-type: text/plain; name=xdr.c-2.4.22-rc1-ac1.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=xdr.c-2.4.22-rc1-ac1.diff

--- linux-2.4.22-rc1-ac1-orig/net/sunrpc/xdr.c	Fri Aug  8 22:34:34 2003
+++ linux-2.4.22-rc1-ac1-fixed/net/sunrpc/xdr.c	Sat Aug  9 10:50:39 2003
@@ -231,7 +231,7 @@
 		iov->iov_base = (char *)xdr->tail[0].iov_base + base;
 		iov++;
 	}
- out:
+
 	return (iov - iov_base);
 out_err:
 	for (; first_kmap != ppage; first_kmap++)

--Boundary_(ID_eINmfEJFBaKaE/MDx+vycA)--
