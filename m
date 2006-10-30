Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWJ3KRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWJ3KRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWJ3KRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:17:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:49140 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161196AbWJ3KRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:17:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O7ZQBtUIGP+B4nQR9F4d9ypmOsGCNj8qzub6gq6qYxg7FtoZ1Pz9PyHz15ZjsS2O4HdF9rRYcWFaevwcnoIZeCds7nt6LGlocypd/Luz/ZJ7iGdjADTFQ4i4jqSgGJNKF/JvlqvIH0aunrUxXHFbryiUWzDLT3xn36wuhqAMeJ8=
Message-ID: <2716c1cd0610300217h3e52081dqd9eca1cfa73f39bf@mail.gmail.com>
Date: Mon, 30 Oct 2006 02:17:31 -0800
From: "Prashant Anand" <panandsapphire@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: mmap of a file that is partially in cache already
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai ,
I am thinking of giving support to mmap of a file that is partially in
page cache using hugetlbfs.What i am thinking is that whenever a file
is too big(in the range of Gigabytes), we can use huge pages and free
the the page frames that have been used by this file so that other
small files may use them.
Using hugepages will reduce TLB misses and hence enhance system
throughput. This will also give other processes to use the page frames
that were used by the file which has been copied into hugepages.Is
there any support for this in linux 2.6 kernel till date?What are the
problems that i may face? Has anyone got any solution for this
problem?
Sincerely,
Prashant Anand
