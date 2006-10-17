Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWJQUD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWJQUD4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWJQUD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:03:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:32639 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWJQUDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:03:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=bsRCFfpqvbmrgPjVBTxmQnTsNhNX/ulDlhcg8L1RDvs2kjrzGDWC2lzS7HUBVa/XYriBrYIH/dKX68Zhv2LczFcvFERJwmtGOWvPJJNJRcqZUre9ttld7COd0+zvdae1EMmCV6xm+yXnWAbTo0Y8+Fz+431VkD0XqIqlnLvHQuw=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: [2.6.19-rc2-mm1] error: too few arguments to function =?utf-8?q?=E2=80=98crypto=5Falloc=5Fhash=E2=80=99?=
Date: Tue, 17 Oct 2006 15:53:44 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <20061016230645.fed53c5b.akpm@osdl.org>
In-Reply-To: <20061016230645.fed53c5b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610171603.38253.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The latest -mm introduced a new error:

  CC      fs/reiser4/plugin/crypto/digest.o
fs/reiser4/plugin/crypto/digest.c: In function ‘alloc_sha256’:
fs/reiser4/plugin/crypto/digest.c:17: error: too few arguments to function ‘crypto_alloc_hash’
make[2]: *** [fs/reiser4/plugin/crypto/digest.o] Error 1
make[1]: *** [fs/reiser4] Error 2
make: *** [fs] Error 2

Andrew Wade
