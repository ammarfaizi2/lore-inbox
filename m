Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVGUUbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVGUUbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 16:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVGUUbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 16:31:03 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:17816 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261835AbVGUUbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 16:31:02 -0400
Date: Thu, 21 Jul 2005 13:30:58 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: njw@osdl.org
Subject: [announce] 'patchview' ver. 003
Message-Id: <20050721133058.791773b8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

[version 003]

'patchview' merges a patch file and a source tree to a set of
temporary modified files.  This enables better patch (re)viewing
and more viewable context.  (hopefully)


The patchview script is here:
  http://www.xenotime.net/linux/scripts/patchview


usage: patchview [-f] patchfile srctree {ver. 003}
  -f : force tkdiff even if 'patch' has errors
  -s : single tkdiff even if patchfile contains multiple files


It uses (requires) lsdiff (from patchutils) and tkdiff.

patchutils:  http://cyberelk.net/tim/patchutils/
tkdiff:      http://sourceforge.net/projects/tkdiff/

---
~Randy


Changes for ver. 003:
- handle patch making empty .orig files (for new files)
  with permission of 000
