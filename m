Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbREVWWa>; Tue, 22 May 2001 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbREVWWU>; Tue, 22 May 2001 18:22:20 -0400
Received: from gateway.sequent.com ([192.148.1.10]:61654 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S262868AbREVWWB>; Tue, 22 May 2001 18:22:01 -0400
Date: Tue, 22 May 2001 15:21:46 -0700
From: "Martin J. Bligh" <mbligh@mail.com>
Reply-To: "Martin J. Bligh" <mbligh@mail.com>
To: linux-kernel@vger.kernel.org
Subject: When is the earliest point I can call ioremap() ?
Message-ID: <2702428599.990544906@W-MBLIG.beaverton.ibm.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to call ioremap fairly early on in kernel init (and it
doesn't work ;-) )

What setup functions have to run before ioremap() will work?

I can debug exactly what it's doing now if I have to, but I
don't suspect it'll tell me much ... I'm calling from aroung
console_init in start_kernel.

Thanks,

Martin.


