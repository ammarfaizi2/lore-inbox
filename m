Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTJBTLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 15:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTJBTLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 15:11:48 -0400
Received: from law11-f114.law11.hotmail.com ([64.4.17.114]:51467 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263462AbTJBTLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 15:11:46 -0400
X-Originating-IP: [220.224.20.254]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: jmorris@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO] Testing Module Cleanup.
Date: Fri, 03 Oct 2003 00:41:45 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F114t5BBBVhye0000106c@hotmail.com>
X-OriginalArrivalTime: 02 Oct 2003 19:11:45.0833 (UTC) FILETIME=[05A40990:01C38919]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I'll do it.


>From: James Morris <jmorris@redhat.com>
>To: kartikey bhatt <kartik_me@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: [CRYPTO] Testing Module Cleanup.
>Date: Thu, 2 Oct 2003 10:35:09 -0400 (EDT)
>
>On Thu, 2 Oct 2003, kartikey bhatt wrote:
>
> > sending it as an attachment
> >
>
>I'm seeing a failure with the 5th DES ECB test vector:
>
>   testing des ECB encryption
>   [...]
>   test 5 (64 bit key):
>   5630092f0161d576
>   fail
>
>Could you also retain the weak key test for DES?  Just add another field
>to the test vector struct to indicate that CRYPTO_TFM_REQ_WEAK_KEY needs
>to be set prior to setkey(), then clear it after the test.  (Once you do
>this the above test vector should fail anyway, which is probably why it
>is buggy -- it's never been run).
>
>Also, a minor nit: please be careful about this kind of thing:
>
>- * Copyright (c) 2002 Jean-Francois Dive <jef@linuxbe.org>$
>+ * Copyright (c) 2002 Jean-Francois Dive <jef@linuxbe.org> ^I$
>
>
>Otherwise, it looks good.
>
>Thanks,
>
>
>- James
>--
>James Morris
><jmorris@redhat.com>
>
>

_________________________________________________________________
Contact brides & grooms FREE! http://www.shaadi.com/ptnr.php?ptnr=hmltag 
Only on www.shaadi.com. Register now!

