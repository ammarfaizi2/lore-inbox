Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSDINIt>; Tue, 9 Apr 2002 09:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312311AbSDINIs>; Tue, 9 Apr 2002 09:08:48 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:61957 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312253AbSDINIr>;
	Tue, 9 Apr 2002 09:08:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Mon, 08 Apr 2002 22:04:54 +1000."
             <3127.1018267494@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Apr 2002 23:08:35 +1000
Message-ID: <29447.1018357715@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New core, common and ia64 code for kbuild 2.5 is available in
http://sourceforge.net/project/showfiles.php?group_id=18813&release_id=83065

Changes from core-2 to core-3.

  Ensure that database records are aligned.  Do not assume that keys
  are aligned (all the world is not a 386).

Changes from common-2.4.18-1 to common-2.4.18-2.

  Minor changes to common code to suit ia64.

New, ia64-020226-2.4.18-1.

core-3 works on ia64, it should work on other architectures that have
alignment requirements such as sparc.

Other architecture maintainers can use core-3 and common-2.4.18-2 as a
starting point for porting this release of kbuild 2.5 to their
architecture.  The existing arch patches from Release 1.12 are a good
starting point, ia64 was almost unchanged from Release 1.12 to 2.0.

I have not tested any of the kbuild 2.5 code on big endian machines.
It should work as is but it would be nice to have it confirmed.

