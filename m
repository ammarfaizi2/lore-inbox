Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWBAPMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWBAPMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWBAPMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:12:23 -0500
Received: from fmr21.intel.com ([143.183.121.13]:45717 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932468AbWBAPMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:12:21 -0500
Message-Id: <200602011511.k11FBgg00314@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Akinobu Mita'" <mita@miraclelinux.com>, "Grant Grundler" <iod00d@hp.com>
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH 1/12] generic *_bit()
Date: Wed, 1 Feb 2006 07:11:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYiKR4r4xPfGPGJRoKSZm+jiuN1pwFGFSLA
In-Reply-To: <20060126032918.GB9984@miraclelinux.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote on Wednesday, January 25, 2006 7:29 PM
> This patch introduces the C-language equivalents of the functions below:
> 
> - atomic operation:
> void set_bit(int nr, volatile unsigned long *addr);
> void clear_bit(int nr, volatile unsigned long *addr);
> void change_bit(int nr, volatile unsigned long *addr);
> int test_and_set_bit(int nr, volatile unsigned long *addr);
> int test_and_clear_bit(int nr, volatile unsigned long *addr);
> int test_and_change_bit(int nr, volatile unsigned long *addr);

I wonder why you did not make these functions take volatile
unsigned int * address argument?

- Ken

