Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbTJAVTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbTJAVTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:19:08 -0400
Received: from fmr04.intel.com ([143.183.121.6]:7563 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262602AbTJAVS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:18:57 -0400
Message-ID: <3F7B4453.9020902@intel.com>
Date: Wed, 01 Oct 2003 14:17:07 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
       pavel@suse.cz
Subject: [PATCH] ioctl32 fix to SG_IO
Content-Type: multipart/mixed;
 boundary="------------080905060809000300070903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080905060809000300070903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


A minor bug fix to the ioctl32 code handling SG_IO. sgio->dxferp is not initialzed properly.

	-Arun

--------------080905060809000300070903
Content-Type: text/plain;
 name="ioctl32-sgio.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ioctl32-sgio.patch"

LS0tIGlhNjQtbGludXgyLjYuMC9mcy9jb21wYXRfaW9jdGwuYwlTdW4gU2VwIDI4IDA5OjU0
OjIzIDIwMDMKKysrIGlhNjQtbGludXgyLjYuMC1wYXRjaC9mcy9jb21wYXRfaW9jdGwuYwlT
dW4gU2VwIDI4IDA5OjU0OjM3IDIwMDMKQEAgLTEwMjksNiArMTAyOSw3IEBACiAJCQlyZXR1
cm4gLUVGQVVMVDsKIAl9CiAKKwlzZ2lvLT5keGZlcnAgPSBpb3Y7CiAJcmV0dXJuIDA7CiB9
CiAK
--------------080905060809000300070903--

