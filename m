Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUERXc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUERXc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUERXc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 19:32:57 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:49860 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263735AbUERXck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 19:32:40 -0400
Date: Tue, 18 May 2004 16:32:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: bitkeeper-announce@work.bitmover.com
Cc: linux-kernel@vger.kernel.org
Subject: bk-3.2.0 released
Message-ID: <20040518233238.GC28206@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BitKeeper Users,

BK/Pro 3.2.0 has been released and is in the BK download area,

    http://bitmover.com/download

We're departing from our previous tradition of letting the word out slowly,
people didn't like that.  Because of that, we suggest that cautious users
wait for a week or two to make sure that any lingering bugs have been caught.
The rest of you go bang on it and let us know if we missed anything please.

As always, please use "bk sendbug" to file any bug reports for this
release.

The next effort from us will be a commercial release we hope to have
out in mid-summer.

Thanks and enjoy,

The BitKeeper Team

===============================================================================
Release notes for BitKeeper version 3.2.0.   These release notes cover
the following topics:

. Upgrade Notes
. New Features
. Noteworthy bug fixes

Upgrade notes
----------------------------------------------------------------------------

  On Microsoft Windows, BitKeeper no longer requires (or uses) Cygwin.
  You may use Cygwin if you like but BitKeeper does not need it; BK
  is completely self contained.  

  Registry management, uninstall, and upgrades should work substantially
  better than they have in the past.

New Features
----------------------------------------------------------------------------

  A simple pager called 'bk more' is included and will be used if no
  suitable pager can be found.

  Under Windows the SCCS dirs are now created with the "hidden" attribute.

  HPUX 11.11 is now a supported platform.

  A new command called 'bk lease'.  This is primarily for openlogging users.
  Please see 'bk helptool lease' for more information.

Noteworthy Bug Fixes
----------------------------------------------------------------------------

  2004-01-19-002: Fix resolve bug where 'vr' (view remote) didn't work
  2004-01-27-001: Fix include/exclude processing in 'bk export'
  2004-02-06-002: bk export: fix error case for missing src directory
  2004-03-12-001: Don't delete a RESYNC directory we didn't create
  2004-04-19-001: Fix regression in bk send
  2004-04-23-001: Fix HTTP requests to match standards
  
  Remove an extra unneeded consistency check on the first commit
  after every clone.

  Fixed bug in citool that causes comments for pending files to not
  show up in the bottom window when the ChangeSet file is selected.

  Fix problem in BkWeb where the "N weeks" times didn't match
  reality.

  Improve documentation for which characters are legal in tags and add more
  error checks on tag names.
						   
  Prevent people from passing bad options to 'bk comments'.
  
  Always write keys to BitKeeper/etc/csets-in instead of revs or
  serial numbers.

  Fix a case where 'bk repogca' could return the wrong answer.

  Fix case where BitKeeper didn't work correctly with PGP 8.0 on
  Windows.

  Set time stamps correctly after running 'bk fix'.

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
