Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbUDOQZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUDOQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:25:29 -0400
Received: from ns.caseta.com ([68.160.74.213]:16095 "EHLO mailhost.caseta.com")
	by vger.kernel.org with ESMTP id S264338AbUDOQZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:25:22 -0400
From: "slapin" <slapin@caseta.com>
To: "'szonyi calin'" <caszonyi@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: multithreaded coredump in 2.6
Date: Thu, 15 Apr 2004 12:25:22 -0400
Organization: Caseta Technologies Inc.
Message-ID: <001601c42306$3fe191e0$5b00000a@caseta.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20040415155816.47730.qmail@web40608.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> owner@vger.kernel.org] On Behalf Of szonyi calin


> AFAIK the default name of the core file is core. So if you have
> 300 threads they could overwrite the file to one another.
> You can customize the core file naming:
> /proc/sys/kernel/core_pattern
> 
> see Documentation/sysctl/kernel.txt in your kernel tree
> 

I use pid in a core file name so it looks like core.2345. It's not it.

Thanks,
Sergey Lapin


