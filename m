Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312610AbSDJLsR>; Wed, 10 Apr 2002 07:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSDJLsQ>; Wed, 10 Apr 2002 07:48:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:65035 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312610AbSDJLsQ>;
	Wed, 10 Apr 2002 07:48:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Tue, 09 Apr 2002 23:08:35 +1000."
             <29447.1018357715@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Apr 2002 21:48:02 +1000
Message-ID: <6278.1018439282@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New core and common code for kbuild 2.5 is available in
http://sourceforge.net/project/showfiles.php?group_id=18813&release_id=83065

Changes from core-3 to core-4.

  GNUism removal.
  WISH is exposed in case your wish binary is not in /usr/bin/wish.
  awk changed to $(AWK) throughout.
  PP_variables added to expose headers and compiler flags that might be
  different on on non-Linux build platforms.
  Force the use of KBUILD_SHELL instead of relying on a working build
  platform shell.
  Drop back to getopt if getopt_long is not available on the build
  platform, in which case only the single character command flags are
  available.
  Documentation updates.

  *** kbuild 2.5-core-4 runs on Solaris using gcc, gmake, gawk. ***

  Would any brave (or foolhardy) person like to run kbuild 2.5 under
  Cygwin or other build platforms?

Changes from common-2.4.18-2 to common-2.4.18-3.

  Yet more aic7xxx problems :(
  Documentation updates.
  Correct fencepost error in scripts/tkparse.

Changes from common-2.4.19-pre6-1 to common-2.4.19-pre6-2.

  As for  common-2.4.18-2 -> 3.

