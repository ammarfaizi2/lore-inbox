Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269197AbUISIr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269197AbUISIr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 04:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269198AbUISIr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 04:47:29 -0400
Received: from dialup-4.246.81.241.Dial1.SanJose1.Level3.net ([4.246.81.241]:33157
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S269197AbUISIr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 04:47:28 -0400
Reply-To: <syphir@syphir.sytes.net>
From: "C.Y.M." <syphir@syphir.sytes.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9-rc2-bk4 Unknown symbol __VMALLOC_RESERVE
Date: Sun, 19 Sep 2004 01:47:22 -0700
Organization: CooLNeT
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAJihS6b3JIU+sat00m7mYfgEAAAAA@syphir.sytes.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <414D2A65.4080605@blueyonder.co.uk>
Thread-Index: AcSeFFjTySo+YzXRQ9ux+pgbQv5DkgAEMSUg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> There is a recent post with details of what's needed for the nvidia 
> driver to compile and work. Links to patched are included. 
> For that one, 
> put as the first line in nv.c
> unsigned int __VMALLOC_RESERVE;
> 

Thanks, this fixes the problem.

