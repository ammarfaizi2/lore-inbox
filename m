Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261217AbREQG1t>; Thu, 17 May 2001 02:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261251AbREQG1j>; Thu, 17 May 2001 02:27:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49562 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261217AbREQG11>;
	Thu, 17 May 2001 02:27:27 -0400
Date: Thu, 17 May 2001 02:27:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [What the...] sti() in device_init()
Message-ID: <Pine.GSO.4.21.0105170221000.27492-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, what the hell is sti(); doing in device_init()?  It's
done _much_ earlier (before calibrate_delay(); in start_kernel())
and I don't see anything that would require repeating it...

	Looks bogus for me... Linus?

								Al

