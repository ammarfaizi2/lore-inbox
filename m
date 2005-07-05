Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVGES3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVGES3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVGES3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:29:04 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:5954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261953AbVGESXl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:23:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fyScPvY7AGdGG+2sQ2ADhEmmuQ7Qr9Qcj5/T6A+1MmSvroUhnQz80fXd25GPJ4tx5gtqD4stdh/CBV+vAfTwrOI+qJkwv1UxJfM9HFxgH1LY/WVVdzZs4X1A5F3MI/P3ISC1QTyaMJZxNBBI+eBO+Uk45WMRxSamNOP7aiWJwq0=
Message-ID: <4ae3c140507051123758bb61e@mail.gmail.com>
Date: Tue, 5 Jul 2005 14:23:39 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why cannot I do "insmod nfsd.ko" directly?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to do "insmod nfsd.ko", but always got the error message
"insmod: error inserting 'nfsd.ko': -1 Unknown symbol in module"

Why?

The kernel is 2.6.11.10
The command I used is:
1. insmod lockd.ko  ---succeed
2. exportfs -r   ---succeed
3. insmod nfsd.ko --- failed 


Moreover, I noticed that if I do the following commands, nfsd.ko can
be inserted:

1. rpc.mountd
2. exportfs -r
3. rpc.nfsd 1

Can someone explain what trick rpc.mountd and rpc.nfsd do to make
nfsd.ko insertable?

Thanks in advance for your kind help!

-x
