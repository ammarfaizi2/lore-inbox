Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290448AbSA3Sv7>; Wed, 30 Jan 2002 13:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSA3Suk>; Wed, 30 Jan 2002 13:50:40 -0500
Received: from MORGOTH.MIT.EDU ([18.238.2.157]:54658 "EHLO morgoth.mit.edu")
	by vger.kernel.org with ESMTP id <S290347AbSA3St6>;
	Wed, 30 Jan 2002 13:49:58 -0500
Date: Wed, 30 Jan 2002 13:49:50 -0500
From: Alex Khripin <akhripin@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: BKL in tty code?
Message-ID: <20020130184950.GA22442@morgoth.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm very much a newbie, and I'm wondering about the big kernel locks
in tty_io.c. What exactly are the locks in the read and write for? Is the
tty device that contested? Couldn't a finer grained lock be used?
-Alex Khripin
