Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262537AbRE3BKa>; Tue, 29 May 2001 21:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbRE3BKV>; Tue, 29 May 2001 21:10:21 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:2184 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262537AbRE3BKJ>; Tue, 29 May 2001 21:10:09 -0400
Date: Tue, 29 May 2001 21:09:58 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac3: qlogic corruption on alpha
Message-ID: <20010529210958.A821@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i narrowed down some corruption i was having. it only happens on drives
attached to my qlogic isp card. 2.2 has no problem, and in 2.4.5-ac3 my
sym53c875 works fine. this machine is an alpha miata. it only happens when
writing out a lot to disk. eg, untarring a kernel tarball, restoring a
backup. anyone else see this?

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
