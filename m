Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269137AbUJFI7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269137AbUJFI7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269146AbUJFI7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:59:37 -0400
Received: from palrel13.hp.com ([156.153.255.238]:33955 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S269137AbUJFI7E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:59:04 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16739.46035.897839.631002@napali.hpl.hp.com>
Date: Wed, 6 Oct 2004 01:58:59 -0700
To: Christian =?iso-8859-1?q?Borntr=E4ger?= <cborntra@de.ibm.com>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IA64: fix unprotected access of user memory in system call emulation layer
In-Reply-To: <200410061050.15337.cborntra@de.ibm.com>
References: <200410061050.15337.cborntra@de.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 6 Oct 2004 10:50:15 +0200, Christian Bornträger <cborntra@de.ibm.com> said:

  Christian> Hello, the current IA64/IA32 emulation layer might oops
  Christian> due to an unprotected access of user memory.  This patch
  Christian> fixes the problem by using the data from __get_user.
  Christian> Please Apply

Already fixed (since yesterday!):

 http://lia64.bkbits.net:8080/linux-ia64-release-2.6.9/cset@416225cfObm2S3bJVFhQdG2mIL71rw

Thanks,

	--david
