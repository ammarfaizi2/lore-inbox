Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSIBIRN>; Mon, 2 Sep 2002 04:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSIBIRN>; Mon, 2 Sep 2002 04:17:13 -0400
Received: from na.sdn.net.za ([66.8.40.138]:40721 "EHLO riva.fashaf.co.za")
	by vger.kernel.org with ESMTP id <S318207AbSIBIRM>;
	Mon, 2 Sep 2002 04:17:12 -0400
From: mk@fashaf.co.za
Date: Mon, 2 Sep 2002 10:21:56 +0200
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.18 Kernel Panics related to Netfilter/iptables
Message-ID: <20020902082156.GA28503@fashaf.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.4.18-3
X-Editor: VIM - Vi IMproved 6.1 (http://www.vim.org/)
X-Crypto: gpg (GnuPG) 1.0.7 (http://www.gnupg.org/)
X-GPG-Key-ID: AA91CF25
X-GPG-Key-Fingerprint: 8D0B F1A3 5296 6CBC 7509  05B0 F3B8 CEF2 AA91 CF25
X-What-Happen: somebody set up us the bomb.
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

One of my machines running kernel 2.4.18 is getting kernel panics intermittently (30minutes to 4/5 hours). 

from the logs I believe is the culprit:

kernel: LIST_DELETE: ip_conntrack_core.c:165 `&ct->tuplehash[IP_CT_DIR_REPLY]'(c6c78e44) not in &ip_conntrack_hash [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].

After searching google for a while i noticed this was the exact error for problems with the 2.4.10 kernel and apparently have been fixed. Here is the link:

http://lists.netfilter.org/pipermail/netfilter-announce/2002/000010.html

If you need any additional information let me know. Here /proc/version for the moment: 
Linux version 2.4.18 (root@roadkill) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #1 SMP Mon Jun 17 18:06:40 SAST 2002

Hopefully someone can help me resolve this issue.

Thanks
Merritt
