Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135549AbRDSFBP>; Thu, 19 Apr 2001 01:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135550AbRDSFBF>; Thu, 19 Apr 2001 01:01:05 -0400
Received: from mail.kdt.de ([195.8.224.4]:32517 "EHLO mail.kdt.de")
	by vger.kernel.org with ESMTP id <S135549AbRDSFAo>;
	Thu, 19 Apr 2001 01:00:44 -0400
Mail-Copies-To: never
To: "Robert G. Brown" <rgb@phy.duke.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: FPE's
In-Reply-To: <Pine.LNX.4.30.0104181920140.32745-100000@ganesh.phy.duke.edu>
From: Andreas Jaeger <aj@suse.de>
Date: 19 Apr 2001 06:50:29 +0200
In-Reply-To: <Pine.LNX.4.30.0104181920140.32745-100000@ganesh.phy.duke.edu> ("Robert G. Brown"'s message of "Wed, 18 Apr 2001 19:23:52 -0400 (EDT)")
Message-ID: <u8r8yp4hnu.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ISO C demands that at process startup all FPU traps are masked.  You
can set specific traps with the functions in <fenv.h> from the C
library, for details read the manual: info libc 

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
