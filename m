Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRBJAt1>; Fri, 9 Feb 2001 19:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130916AbRBJAtR>; Fri, 9 Feb 2001 19:49:17 -0500
Received: from mail.valinux.com ([198.186.202.175]:43525 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S130438AbRBJAtE>;
	Fri, 9 Feb 2001 19:49:04 -0500
Date: Fri, 9 Feb 2001 16:49:03 -0800 (PST)
From: Jason Collins <jcollins@valinux.com>
To: <va-ctcs-users@lists.sourceforge.net>
cc: <linux-kernel@vger.kernel.org>
Subject: VA-CTCS 1.3.0pre1
Message-ID: <Pine.LNX.4.30.0102091542050.26410-100000@beefcake.hdqt.valinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux-kernel members, please CC me on reply>

It's been far too long, but a new development branch of VA-CTCS (VA
Cerberus Test Control System) is finally available.  VA Linux has heard my
pleas for increased manpower in my area so ... expect both minor and major
releases to turn over faster than the glacial pace of the last six months.

Highlights since 1.2.xx:
	- Compiles and runs cleanly under the 2.4 kernel
	- Removed some of the third party packages in VA-CTCS to ease
	  my maintenance load
	- Changed the memory test size computations for the default burn
	  to fit in with my better knowledge of the Linux VM.  In
	  particular, avoid exceeding the borrow thresholds in
	  /proc/sys/vm/buffermem, et. al., to keep from wasting
	  time swapping.
	- Added a simple ASCII-only report generator
	- Massive updates to the FAQ and other documentation
	- The usual round of bugfixes

See the SourceForge project page for release notes, changelog, mailing
list, and downloads:

http://sourceforge.net/projects/va-ctcs

Thanks, and happy system thrashing!

--
Jason T. Collins
Software Engineer
VA Linux Systems

(For those unfamiliar with Cerberus...)
****
The VA Cerberus Test Control System is a simple, modular test bench with
modules that can be recombined to beat on hardware and kernels.  The
included burn-in system combines the modules to try to break hardware.
VA Linux Systems uses VA-CTCS to test kernel stability as well as the
reliability of the systems we ship under load.  It is available under the
GNU General Public License.
****

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
