Return-Path: <linux-kernel-owner+w=401wt.eu-S1751209AbXAPOh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXAPOh7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXAPOh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:37:59 -0500
Received: from thccv19.oz.nthu.edu.tw ([140.114.63.219]:55253 "EHLO
	thccv19.oz.nthu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbXAPOh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:37:59 -0500
From: "Yu-Chen Wu" <g944370@oz.nthu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Can_a_buffer_allocated_by_=22vmalloc=28_=29=22_be_used_to_ma?=
	=?US-ASCII?Q?ke_DMA_transmission_=28the_buffer_will_be_used_by_BIO_struct?=
	=?US-ASCII?Q?ure=29_on_X86=5F64_platform=3F?=
Date: Tue, 16 Jan 2007 22:37:56 +0800
Message-ID: <015c01c7397b$e9eb6fb0$0100a8c0@sslabmayasky>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: Acc5e+hybJYeB8ixR6i5fSBQBtjF1w==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Can a buffer allocated by "vmalloc( )" be used to make DMA transmission (the
buffer will be used by BIO structure) on X86_64 platform?
I need a big buffer (cache) maybe 64MB or bigger, so I call vmalloc to
allocate the buffer.
If possible, how to get the pages in the buffer?

Thanks



