Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbUDAJDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUDAJDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:03:34 -0500
Received: from 228.17.30.61.isp.tfn.net.tw ([61.30.17.228]:17792 "EHLO
	cm-msg-02.cmedia.com.tw") by vger.kernel.org with ESMTP
	id S262791AbUDAJDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:03:31 -0500
content-class: urn:content-classes:message
Subject: RE: ANN: cmpci 6.67 released
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Date: Thu, 1 Apr 2004 16:56:40 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D40C@cm-msg-02.cmedia.com.tw>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ANN: cmpci 6.67 released
Thread-Index: AcQXtYSr8MObXkgYTYqlKNNCNpLQwQAEG3Pt
From: =?big5?B?Qy5MLiBUaWVuIC0gpdCp08Kn?= <cltien@cmedia.com.tw>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-audio-dev@music.columbia.edu>,
       =?big5?B?pqyrSLhzstUtuvSttiBTdXBwb3J0IKtIvWM=?= 
	<support@cmedia.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Because I subscribed to linux-kernel recently, so I didn't get the patch after the cmpci.c posted (A user posted it). The driver after 6.0 has added kernel patch so I posted patches based on my CVS from them.

To me it is easier to keep one version for kernel 2.4 and 2.6, with a few patches, that keeps driver functions consistent.

I can post changes since my 5.64 (current version for kernel 2.6) and to 6.16 (kernel version for kernel 2.4) and the diff file of 5.64 of mine and the kernel.

Sincerely,
ChenLi Tien


-----Original Message-----
From:	Andrew Morton [mailto:akpm@osdl.org]
Sent:	2004/4/1 [星期四] 上午 01:49
To:	C.L. Tien - 田承禮
Cc:	linux-kernel@vger.kernel.org; linux-audio-dev@music.columbia.edu; 收信群組-網頁 Support 信箱
Subject:	Re: ANN: cmpci 6.67 released
C.L. Tien - _________ <cltien@cmedia.com.tw> wrote:
>
> 
> Hi,
> 
> I made serveral changes for 6.64, the change are as following:

To what kernel do these patches apply?  Certainly not current 2.6.

If you intend to raise 2.6 patches, please ensure that they are against the
latest kernel.org kernel.  And please ensure that the patches are in `patch
-p1' form.  The headers should look like:

--- a/sound/oss/cmpci.c 22 Mar 2004 17:07:02 -0000      6.64
+++ a/sound/oss/cmpci.c 29 Mar 2004 22:58:49 -0000      6.65

Also, a single patch per email is preferred.

Thanks.



