Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131304AbRC3Jrk>; Fri, 30 Mar 2001 04:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRC3Jqe>; Fri, 30 Mar 2001 04:46:34 -0500
Received: from ghost.btnet.cz ([62.80.85.74]:58884 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S131300AbRC3Jpa>;
	Fri, 30 Mar 2001 04:45:30 -0500
Date: Fri, 30 Mar 2001 10:48:25 +0200
From: clock@ghost.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: g_NCR5380.o module removal bug
Message-ID: <20010330104825.A8491@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realized that removing the module while in usage OOPSES the kernel and
only the alt-sysrq-usb helps. I thought it should write some error message
and do nothing.

-- 
Karel Kulhavy                     http://atrey.karlin.mff.cuni.cz/~clock
