Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279524AbRJ2VIQ>; Mon, 29 Oct 2001 16:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279529AbRJ2VIG>; Mon, 29 Oct 2001 16:08:06 -0500
Received: from pacujo.datastreet.com ([208.179.44.95]:46865 "EHLO
	lumo.pacujo.nu") by vger.kernel.org with ESMTP id <S279524AbRJ2VHz>;
	Mon, 29 Oct 2001 16:07:55 -0500
Date: Mon, 29 Oct 2001 13:07:25 -0800
From: Marko Rauhamaa <marko@pacujo.nu>
Message-Id: <200110292107.NAA09665@lumo.pacujo.nu>
To: linux-kernel@vger.kernel.org
Subject: Need blocking /dev/null
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed that I need a pseudodevice that opens normally but blocks all
reads (and writes). The only way out would be through a signal. Neither
/dev/zero nor /dev/null block, but is there some other standard device
that would do the job?

If there isn't, writing such a pseudodevice would be trivial. What
should it be called? Any chance of including that in the kernel?


Marko

-- 
Marko Rauhamaa    mailto:marko@pacujo.nu     http://www.pacujo.nu/marko/
