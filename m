Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRKBUml>; Fri, 2 Nov 2001 15:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280826AbRKBUmb>; Fri, 2 Nov 2001 15:42:31 -0500
Received: from koala.rsee.net ([208.171.236.139]:63239 "HELO koala.rsee.net")
	by vger.kernel.org with SMTP id <S280823AbRKBUmT>;
	Fri, 2 Nov 2001 15:42:19 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem with dynamic executables in chroot environments
Message-ID: <1004733335.3be30397831e5@koala.rsee.net>
Date: Fri, 02 Nov 2001 15:35:35 -0500 (EST)
From: Rob See <rob@rsee.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 169.226.44.180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I'm using kernel 2.4.13 and am experiencing problems with dynamic executables 
in chroot environments and also in the initrd environment. These problems don't 
seem to have existed in 2.4.9 or 2.4.12. In the chroot and initrd 
environments , static executables run as expected but dynamic ones always 
return permission denied (EACCESS according to strace.) I don't believe it is a 
library issue because the same environments (and initrds) work fine with the 
2.4.9 and 2.4.12 releases. Does anyone have any ideas about what I might have 
done wrong (odd kernel option, etc.. ), or is this a bug ?


Thanks,
-Rob
