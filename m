Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279858AbRJaCUx>; Tue, 30 Oct 2001 21:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279862AbRJaCUn>; Tue, 30 Oct 2001 21:20:43 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:20753 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S279858AbRJaCUa>; Tue, 30 Oct 2001 21:20:30 -0500
Date: Wed, 31 Oct 2001 02:21:05 +0000
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: rmmod whilst reading/writing sysctl
Message-ID: <20011031022104.C22156@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where is the prevention of module unload whilst a sysctl from a module is being read/written ?

sysctl syscall is protected by BKL, but I can't see similar code for the cat >/proc/sys/...
case

If there is none, how do I support sysctl from a module safely ?

thanks
john

-- 
"I'm dismayed whenever libertarianism and programming are associated; in my
 mind, it is as nebulous as associating people who write books as communists or
 those who read newspapers as capitalists."
	- graydon
