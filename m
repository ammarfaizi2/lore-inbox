Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWJYAJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWJYAJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 20:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161291AbWJYAJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 20:09:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:28409 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1160997AbWJYAJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 20:09:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole:message-id;
        b=rJxuUBOezfkRF6tGLqAAkmdnAMET0gc+NN4YE+JJx/KWEafcDLA16bb+lt9rMiV5GmbF6cPnirZJfSwq6yVnxdDHvd5XUrmaM5bSALzfa6exaRVsZJf+ZZCjo1tBlBcAG+4+GRk3qOfOHxt38NaXD39FSsp7gdVYtNkQJXjf/9E=
From: "Michael" <michael.sallaway@gmail.com>
To: "'Badari Pulavarty'" <pbadari@gmail.com>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Oops when doing disk heavy disk I/O
Date: Wed, 25 Oct 2006 10:09:07 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1161711790.18096.29.camel@dyn9047017100.beaverton.ibm.com>
Thread-Index: Acb3k+KQ+ucFxXb+QlWUS0Arzi54WAANYfxA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <453eab2d.2b0389e9.25a6.ffff9184@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> From: Badari Pulavarty [mailto:pbadari@gmail.com] 
> Sent: Wednesday, 25 October 2006 3:43 AM
> 
> > Other things I have tried:
> > - SATA, SCSI and IDE drives -- all do the same thing
> > - removing *all* drives and cards and devices -- it does it with a
> > single IDE drive connected and no PCI cards
> > - kernels 2.6.16, 18, 18.1, 19-rc3.
> 
> All of these kernels are having the same problem ? Or just noticed
> it only in 19-rc3 ?
> 

All of them. I was going to try earlier kernels, but from my googling it
sounds like nforce 5xx support wasn't incorporated until recently (could be
wrong, though.)

Thanks,
Michael

