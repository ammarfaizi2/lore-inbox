Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293379AbSCGGBk>; Thu, 7 Mar 2002 01:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSCGGBU>; Thu, 7 Mar 2002 01:01:20 -0500
Received: from adsl-209-233-33-110.dsl.snfc21.pacbell.net ([209.233.33.110]:63740
	"EHLO lorien.emufarm.org") by vger.kernel.org with ESMTP
	id <S293379AbSCGGBL>; Thu, 7 Mar 2002 01:01:11 -0500
Date: Wed, 6 Mar 2002 22:01:10 -0800
From: Danek Duvall <duvall@emufarm.org>
To: linux-kernel@vger.kernel.org
Subject: root-owned /proc/pid files for threaded apps?
Message-ID: <20020307060110.GA303@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded from 2.4.8-pre3-ac2 to 2.4.19-pre2-ac2, and found that
for threaded programs like mozilla and xmms, files in /proc/<pid> are
owned by root, even if the process belongs to another user.  I
particularly wanted to be able to read /proc/<pid>/environ, but I can't.

Is this a known problem?  I haven't seen it float by.

I'll backtrack kernels to see if I can find the patch that caused it and
report back if I hear nothing.

Thanks,
Danek
