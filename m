Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbRLVQue>; Sat, 22 Dec 2001 11:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286822AbRLVQuY>; Sat, 22 Dec 2001 11:50:24 -0500
Received: from pop.gmx.de ([213.165.64.20]:30540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S286821AbRLVQuO>;
	Sat, 22 Dec 2001 11:50:14 -0500
Date: Sat, 22 Dec 2001 17:50:07 +0100
From: Andreas Kinzler <akinzler@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Injecting packets into the kernel
X-Mailer: Andreas Kinzler's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011222165020Z286821-18284+6166@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to fix a problem in diald (demand dialing tool). The problem is that
somewhen you need to resubmit IP packets to the kernel that were buffered while the
link (PPP in most cases) was down. However, a bit of debugging showed that the method
used in diald does not work. You cannot submit to ppp0 directly because of masq/forwaring
issues. Can somebody give me some hints how to submit packets from a user mode programm.

Andreas

