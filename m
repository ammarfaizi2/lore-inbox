Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993088AbWJUPIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993088AbWJUPIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 11:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993098AbWJUPIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 11:08:34 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:63610 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S2993088AbWJUPId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 11:08:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ly+bI+9CrbVPkdBs8go27htKb3vLQYJkwAyslZJbQBXaWcXocFVcOXT5k6br2WP3gOLCELGD2KSP4TS0iYPAFSKfsIwzyZUWRB5RXBOvF/UOHqNrYaEO/voebV9b/FM+/4RWvVtqiySmjfIgUxPemCg/yc3cRxOAieQtSNYfaVw=
Message-ID: <b0943d9e0610210808g462c737cq7828b7c9f0ad9367@mail.gmail.com>
Date: Sat, 21 Oct 2006 16:08:31 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: git <git@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Stacked GIT 0.11
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stacked GIT 0.11 release is available from http://www.procode.org/stgit/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

The main features in this release:

*  New 'float' command to bring a range patches to the top of the
stack. This command can also take a series file as a parameter,
allowing easy reordering of the patches
* Patch history support, accessible through the 'log [--graphical]' command
* Use the '..' syntax for patch ranges instead of ':'
* '--keep' option for 'pop' to preserve the local changes (useful to
add the modifications to a different patch)
* '--graphical' option for 'series' to invoke gitk instead of listing
the patches
* Automatically generate patch names for the 'import', 'pick' and
'uncommit' commands
* '--noreply' option for 'mail' to not send messages as replies to the
first one. This is useful for mailing lists filtering replies with a
different subject
* '--interactive' option for 'resolved' to invoke a graphical 3-way
merge tool (xxdiff or emacs)
* '--sign' and '--ack' options for 'refresh' to sign off or acknowledge a patch
* Diff colouring pager script added to the contrib directory
* Configurable low-level pull command (i.e. git-pull)
* '--auto' option for 'mail' to automatically cc the patch signers
* Debian package support files
* Bug fixes


Acknowledgements (generated with 'git shortlog'):

Catalin Marinas:
      Do not use the pager when the output is empty
      Get the patch name from the description
      Add '--' to git-diff-index calls
      Add a common function for reading template files
      Automatically generate patch names for uncommit
      Set the .txt extension to the StGIT commit message file
      Use the ".." syntax for patch ranges
      Use get-ref-list to get the commit parents
      Add --keep option to pop
      Allow empty commit messages
      Add the --graphical option to series
      Add patch history support
      Add the --noreply option to 'mail'
      TODO list update
      Add the '--interactive' option to 'resolved'
      Add --sign and --ack options to refresh
      Fix the preserving of the local changes during pop
      Add the diffcol.sh file to the contrib directory
      Allow the git-pull command to be configurable
      Add --auto option to 'mail'
      Rearrange the patches with a given series file
      Add Debian package support to StGIT
      Release 0.11

Robin Rosenberg:
      Fix the --cover option.
      New command 'float' to move a patch to the top

Yann Dirson:
      Add a --parent flag to "stgit pick".

-- 
Catalin
