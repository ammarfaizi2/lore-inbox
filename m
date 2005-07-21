Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVGUAdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVGUAdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 20:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVGUAch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 20:32:37 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:25986 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261571AbVGUAcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 20:32:35 -0400
Date: Wed, 20 Jul 2005 17:32:00 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: njw@osdl.org, "K.R. Foley" <kr@cybsft.com>
Subject: [announce] 'patchview' ver. 002
Message-Id: <20050720173200.04c01769.rdunlap@xenotime.net>
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

[version 002]

'patchview' merges a patch file and a source tree to a set of
temporary modified files.  This enables better patch (re)viewing
and more viewable context.  (hopefully)


The patchview script is here:
  http://www.xenotime.net/linux/scripts/patchview


usage: patchview [-f] patchfile srctree {ver. 002}
  -f : force tkdiff even if 'patch' has errors
  -s : single tkdiff even if patchfile contains multiple files


It uses (requires) lsdiff (from patchutils) and tkdiff.

patchutils:  http://cyberelk.net/tim/patchutils/
tkdiff:      http://sourceforge.net/projects/tkdiff/

---
~Randy


Thanks for Nick Wilson and K.R. Foley for patches.

Changes for ver. 002:
- add -s (single) option for only one tkdiff at a time
- better option parsing
- fixed use of 'mktemp'
- exit if mktemp fails
