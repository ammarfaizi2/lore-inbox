Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268506AbTBNVpe>; Fri, 14 Feb 2003 16:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268504AbTBNVpa>; Fri, 14 Feb 2003 16:45:30 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:17368 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S268506AbTBNVpD>; Fri, 14 Feb 2003 16:45:03 -0500
Date: Fri, 14 Feb 2003 23:54:50 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: creating incremental diffs
Message-ID: <20030214215450.GA12233@actcom.co.il>
References: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 09:48:16PM +0100, Maciej Soltysiak wrote:
> Hi,
> 
> let's say i want to create an incremental diff between
> 2.4.21pre4aa1 and aa2.

look for a package called patchutils, which includes interdiff. 

mulix@alhambra:~$ apt-cache show patchutils
Package: patchutils
[snipped]
Description: Utilities to work with patches
 This package includes the following utilities:
  - combinediff creates a cumulative patch from two incremental patches
  - dehtmldiff extracts a diff from an HTML page
  - filterdiff extracts or excludes diffs from a diff file
  - fixcvsdiff fixes diff files created by CVS that "patch" mis-interprets
  - flipdiff exchanges the order of two patches
  - grepdiff shows which files are modified by a patch matching a regex
  - interdiff shows differences between two unified diff files
  - lsdiff shows which files are modified by a patch
  - recountdiff recomputes counts and offsets in unified context diffs
  - rediff fixes offsets and counts of a hand-edited diff
  - splitdiff separates out incremental patches
  - unwrapdiff demangles patches that have been word-wrapped

-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

