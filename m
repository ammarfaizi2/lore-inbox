Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271138AbTGQQEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271150AbTGQQEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:04:45 -0400
Received: from user-10cm126.cable.mindspring.com ([64.203.4.70]:5383 "HELO
	cia.zemos.net") by vger.kernel.org with SMTP id S271138AbTGQQEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:04:42 -0400
Date: Thu, 17 Jul 2003 09:20:26 -0700 (PDT)
From: Gorik Van Steenberge <gvs@cia.zemos.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: cursor dissapears after setfont
Message-ID: <Pine.LNX.4.50L0.0307170849440.30014-100000@cia.zemos.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,


I recently compiled 2.6.0-test1 and noticed that I didn't have a cursor on
any tty but tty1. After testing some things I found out that the cursors
dissapear after "setfont -v default8x9.psfu.gz". Also, the cursor does not
dissapear on the tty that called setconfig. I also had this problem in
2.5.70. AFAIK I'm using the latest kbd.

I am not sure what info I should supply that would be relevant to this
issue.


Linux aeolus 2.6.0-test1-ac1 #4 Thu Jul 17 17:06:38 CEST 2003 i686 unknown

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.32
reiserfsprogs          3.6.4
xfsprogs               2.3.9
nfs-utils              1.0.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         radeon snd_pcm_oss snd_mixer_oss ipt_unclean ipt_state ipt_limit ipt_LOG iptable_filter ip_conntrack ip_tables


Any help on this matter is greatly appreciated,


Regards,

Gorik Van Steenberge
