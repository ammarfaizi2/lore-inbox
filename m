Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267295AbRGPLaD>; Mon, 16 Jul 2001 07:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbRGPL3x>; Mon, 16 Jul 2001 07:29:53 -0400
Received: from [212.141.54.101] ([212.141.54.101]:7062 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S267295AbRGPL3g>; Mon, 16 Jul 2001 07:29:36 -0400
Date: Mon, 16 Jul 2001 13:29:33 +0200
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-pre6 can't complete e2fsck
Message-ID: <20010716132933.A216@fourier.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've upgraded to 2.4.7-pre6aa1 and I'm seeing a strange behaviour:

e2fsck /dev/hda3 never finishes: I can't even stop the process with
CTRL+C. Alt+SysRQ works and it tells me that the number of inactive dirty
pages increases, while the active and free pages decrease.

Alt+SYSRQ+P says the kernel loops mainly in page_launder

Is there a patch to solve this problem?

Gianluca Anzolin
