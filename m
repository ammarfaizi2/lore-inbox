Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQLUPtv>; Thu, 21 Dec 2000 10:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbQLUPtl>; Thu, 21 Dec 2000 10:49:41 -0500
Received: from pD903C628.dip.t-dialin.net ([217.3.198.40]:61445 "HELO
	server.lokalnetz") by vger.kernel.org with SMTP id <S129568AbQLUPtd>;
	Thu, 21 Dec 2000 10:49:33 -0500
Date: Thu, 21 Dec 2000 16:18:01 +0100
To: linux-kernel@vger.kernel.org
Subject: Limiting disk-io
Message-ID: <20001221161801.A9087@mobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Erik Tews <erik.tews@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am going to create a shell-server for a networking-meeting with
cd-writer. Usually, this is not a problem, but I would like to know if
there are any kernel-patches which can limit the io-bandwidth for a user
to the harddisk so that a user which is using the cd-writer has at least
x kb/s.

Renicing the cdrecord-process is only a little bit helpful. It is still
possible to interrupt a cdrecord which is running with priority -20 with
3 or 4 processes which are running with priority 20. So if some users
are starting mkisofs at the same time, then cdrecord will be
interrupted.

Or does anybody know a good userspace-solution?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
