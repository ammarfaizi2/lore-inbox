Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272664AbRILDzC>; Tue, 11 Sep 2001 23:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272665AbRILDyw>; Tue, 11 Sep 2001 23:54:52 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:7686 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S272664AbRILDyr>;
	Tue, 11 Sep 2001 23:54:47 -0400
Date: Wed, 12 Sep 2001 04:55:07 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4 daemonize()
Message-ID: <20010912045507.B4734@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


examples in drivers/ seem undecided on whether the BKL is necessary
during the initial daemonize() and setup of a kernel thread.

must the lock be taken or not ?

thanks
john

-- 
"Since when would the sizeof any kind of pointer be zero ? 
 Have you built a zero-bit CPU ?"
	- Jeffrey Turner
