Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264892AbSJPFpL>; Wed, 16 Oct 2002 01:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264900AbSJPFpL>; Wed, 16 Oct 2002 01:45:11 -0400
Received: from ma-northadams1b-3.bur.adelphia.net ([24.52.166.3]:36809 "EHLO
	ma-northadams1b-3.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S264892AbSJPFpL>; Wed, 16 Oct 2002 01:45:11 -0400
Date: Wed, 16 Oct 2002 01:51:06 -0400
From: Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: can chroot be made safe for non-root?
Message-ID: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am eager to be able to sandbox my processes on a system without the
help of suid-root programs (as I prefer to have none of these on my
system).

Would it be reasonable to allow non-root processes to chroot(), if the
chroot syscall also changed the cwd for non-root processes?

Is there a reason besides standards compliance that chroot() does not
already change directory to the chroot'd directory for root processes?
Would it actually break existing apps if it did change the directory?

-Eric
(who wishes there were better ways to run untrusted code)
