Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSLHP4W>; Sun, 8 Dec 2002 10:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSLHP4W>; Sun, 8 Dec 2002 10:56:22 -0500
Received: from texas.pobox.com ([64.49.223.111]:18653 "EHLO texas.pobox.com")
	by vger.kernel.org with ESMTP id <S261338AbSLHP4U>;
	Sun, 8 Dec 2002 10:56:20 -0500
Date: Sun, 8 Dec 2002 21:33:49 +0530
From: Joshua N Pritikin <vishnu@pobox.com>
To: quinlan@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: longrun not working
Message-ID: <20021208160349.GA712@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a Fujitsu P-Series laptop (TM5800 CPU @ 800MHz) running Linux
2.4.20 (debian) with devfs, CONFIG_MCRUSOE, CONFIG_X86_MSR, and
CONFIG_X86_CPUID.

emit:/usr/src/pseries/longrun# ls -l /dev/cpu/0/
total 0
crw-rw----    1 root     root     203,   0 Dec  8  2002 cpuid
crw-rw----    1 root     root     202,   0 Dec  8  2002 msr

When i try longrun 0.9, i get a failure at the first call to
read_cpuid() in check_cpu(), line 186.

(Actually longrun was working on my laptop about a month ago
then it mysterious started failing, as described.  i don't
know what changed.)

Who is maintaining longrun?  What more information can i provide
to help in debugging?

(If you are replying to a mailing list, please CC my email also.)

-- 
Victory to the Divine Mother!!         after all,
  http://sahajayoga.org                  http://why-compete.org
