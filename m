Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTJESGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 14:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263383AbTJESGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 14:06:04 -0400
Received: from law11-f101.law11.hotmail.com ([64.4.17.101]:12045 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263380AbTJESGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 14:06:00 -0400
X-Originating-IP: [220.224.20.223]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: jmorris@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO] Testing Module Cleanup.
Date: Sun, 05 Oct 2003 23:35:59 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F101ECBlGkVf30000a080@hotmail.com>
X-OriginalArrivalTime: 05 Oct 2003 18:06:00.0163 (UTC) FILETIME=[5513D330:01C38B6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

done it.
sending it as an attachment.

- Kartikey Mahendra Bhatt


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
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________
MSN Hotmail now on your Mobile phone. 
http://server1.msn.co.in/sp03/mobilesms/ Click here.

