Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315270AbSEAAPo>; Tue, 30 Apr 2002 20:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315271AbSEAAPn>; Tue, 30 Apr 2002 20:15:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15863
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315270AbSEAAPm>; Tue, 30 Apr 2002 20:15:42 -0400
Date: Tue, 30 Apr 2002 17:15:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>
Subject: Inactive instead of Inact_dirty, Inact_clean & Inact_target breaks sar
Message-ID: <20020501001536.GC30514@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was just trying out sar (sysstat package in debian), and I noticed that
with an -aa vm several values are blank.

inadtypg, inaclnpg, and inatarpg, represent the three values in /proc/meminfo.

It looks like the best thing to do is simply file a bug against the sar
package, but I thought it deserved mentioning here too.

Thanks,

Mike
