Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTLQUl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 15:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTLQUl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 15:41:29 -0500
Received: from imag.imag.fr ([129.88.30.1]:63668 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S264545AbTLQUl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 15:41:28 -0500
Date: Wed, 17 Dec 2003 21:33:07 +0100
Subject: Re: PCI lib for 2.4 //kwds: pci, dma, mapping memory, kernel vs. user-space.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Peter Chubb <peter@chubb.wattle.id.au>
From: =?ISO-8859-1?Q?Damien_Courouss=E9?= <damien.courousse@imag.fr>
In-Reply-To: <16351.39646.625093.191234@wombat.chubb.wattle.id.au>
Message-Id: <390B816C-30D0-11D8-8955-000393C76BFA@imag.fr>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks a lot, now it's OK differences between user-kernel space. It's a 
bit more clear...

  I guess your perfs info will be usefull... Actually, we do not need 
such high data rates, but we'll have 16 channels to drive I/O, and 
latencies will have to be very short, because there is a real-time loop 
(gesture control). I hope I can do the job without sending to much irqs 
since the real-time task has started.

Damien

