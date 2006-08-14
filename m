Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWHNQTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWHNQTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWHNQTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:19:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:62541 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751488AbWHNQTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:19:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z33vBjGMFo/8NkPDdIMuqD2ieSaT3E9HSKNxpDBLpUspZag3yAG+KJ56iPfgV7yY3gtmCXWQTPU4R6VPUIhsVAe4PC4Xr7EZ+Ij0ScDr0/kQxaE0pPAkUv6Vt4kJihUkh7N2KtMoxJbkleC0c2zI6ZU1P06wq2/nAQQz6Gk1QjY=
Message-ID: <1b270aae0608140918y71725d58h4e38174eac81191d@mail.gmail.com>
Date: Mon, 14 Aug 2006 18:18:44 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: "Phil Oester" <kernel@linuxace.com>
Subject: Re: Problems connecting to www.itu.int with Kernel > 2.6.15
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060814154945.GA25785@linuxace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1b270aae0608140843s33918427vc1ab5771f26ae6bb@mail.gmail.com>
	 <20060814154945.GA25785@linuxace.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've got serious problems connecting to www.itu.int with Kernels > 2.6.15.
> > 2.6.17.X seems to be especially bad and I also tested it with the
> > latest 2.6.17.8 (no change).
> > Receiving data is extremely slow, close to non-existing.
>
> Search the archives for 'window scaling'.

Thanks a lot.
That was the thing I oversaw. Disabling window scaling solved the issue.
ITU admins have been informed.

Cheers,
M.
