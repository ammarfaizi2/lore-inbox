Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTE1V43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTE1V43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:56:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25843 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S261222AbTE1V40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:56:26 -0400
Subject: [announce] procps 2.0.13 with NPTL enhancements
From: Robert Love <rml@tech9.net>
To: procps-list@redhat.com
Cc: linux-kernel@vger.kernel.org, riel@nl.linux.org
Content-Type: text/plain
Message-Id: <1054134550.783.102.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 28 May 2003 15:09:10 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am ecstatic beyond words to announce the release of procps version
2.0.13. This release contains a number of NPTL-related enhancements,
courtesy of Alexander Larsson of Red Hat. Some of the enhancements are
generic in nature, and thus also benefit non-NPTL applications.

I encourage everyone to give this a try, especially 2.5 users.

Tarball, RPM packages, and CVS information is available at:

	http://tech9.net/rml/procps/
	http://sources.redhat.com/procps/

Change Log:

        - fix top(1) -p flag behavior (Lars Holmberg)
        - do not qsort the process list if we are not sorting  
          (Alexander Larsson)
        - read tgid from /proc/pid/status if it exists
          (Alexander Larsson)
        - PROC_SKIPTHREADS flag for ps_readproc() to force only 
          reading of (tgid != pid) to avoid lots of syscalls
          (Alexander Larsson)
        - Look at PM->flags in ps_readproc() to avoid reading
          /proc files files that are not needed. (Alexander Larsson)
        - Support FILLMEM, FILLCMD, FILLENV, FILLWCHAN for above.
          (Alexander Larsson)
        - Fix wchan decoding bug (Alexander Larsson)
        - Fix for ticks going backward and cleanup (Denis Vlasenko)

And other misc. cleanups and changes.

Enjoy,

	Robert "Why the Hell am I maintaining this" Love

