Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUFUTDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUFUTDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUFUTDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:03:02 -0400
Received: from f27.mail.ru ([194.67.57.191]:59396 "EHLO f27.mail.ru")
	by vger.kernel.org with ESMTP id S264396AbUFUTDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:03:00 -0400
From: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= <kksx@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: can TSC tick with different speeds on SMP=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.83.184]
Date: Mon, 21 Jun 2004 23:02:58 +0400
Reply-To: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= 
	  <kksx@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got some stupid question to SMP gurus and would be very thankful for the details. I suddenly faced an SMP system where different P4 cpus were installed (with different steppings). This resulted in different CPU clock speeds and different speeds of time stamp counters on these CPUs. I faced the problem during some timings I measured in the kernel.

So the question is "is such system compliant with SMP specification?".
In old kernels there was a code to syncronize TSCs and to detect if they were screwed up. Current kernels do not have such code. Is it intentional? I suppose there is some code in kernel which won't work find on such systems (real-time threads timing accounting and so on).

Thanks in advance,
Kirill

