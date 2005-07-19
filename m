Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVGSSvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVGSSvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVGSSvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:51:36 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:22138 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261617AbVGSSvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:51:35 -0400
Date: Tue, 19 Jul 2005 11:51:03 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 'patchview' script
Message-Id: <20050719115103.3e10ce0a.rdunlap@xenotime.net>
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

Someone asked me about a tool like this and I didn't know of one,
so I made this little script.

'patchview' merges a patch file and a source tree to a set of
temporary modified files.  This enables better patch (re)viewing
and more viewable context.  (hopefully)

Are there already other tools that do something similar to this?
(other than SCMs)


The patchview script is here:
  http://www.xenotime.net/linux/scripts/patchview

usage: patchview [-f] patchfile srctree
  -f : force tkdiff even if 'patch' has errors


It uses (requires) lsdiff (from patchutils) and tkdiff.

patchutils:  http://cyberelk.net/tim/patchutils/
tkdiff:      http://sourceforge.net/projects/tkdiff/

---
~Randy
