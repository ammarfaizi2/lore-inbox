Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277910AbRJITAB>; Tue, 9 Oct 2001 15:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277908AbRJIS7t>; Tue, 9 Oct 2001 14:59:49 -0400
Received: from cs181196.pp.htv.fi ([213.243.181.196]:4480 "EHLO
	cs181196.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277909AbRJIS7d>; Tue, 9 Oct 2001 14:59:33 -0400
Message-ID: <3BC3492C.DF1320E9@welho.com>
Date: Tue, 09 Oct 2001 21:59:56 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM crash with 2.4.10 & SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just had my machine crash and freeze on a NULL pointer dereference in
page_alloc.c:rmqueue(), called from __alloc_pages(). Looks like it's the
last rmqueue() call in there.

I know, 2.4.10 is buggy buggy buggy. Will be upgrading to pre6 RSN.

Regards,

	MikaL
