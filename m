Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWFTCz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWFTCz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 22:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWFTCz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 22:55:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26338 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965053AbWFTCz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 22:55:57 -0400
Date: Tue, 20 Jun 2006 03:55:52 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Message-ID: <20060620025552.GO27946@ftp.linux.org.uk>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 07:06:39PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 18 Jun 2006, Stefan Richter wrote:
> > 
> > the IEEE 1394 subsystem updates for Linux 2.6.18 are now staged in Ben's
> > revived linux1394 git tree. I guess the URL to pull from is
> > git://git.kernel.org/pub/scm/linux/kernel/git/bcollins/linux1394-2.6.git
> 
> I'm sure that URL works fine, but I want to see what I'm pulling before I 
> pull it, so _please_ use one of the scripts that generates diffstats and 
> shortlogs, or do it by hand..

Hrm...  That's actually one thing git might do - how hard would it be
to teach git-upload-pack to generate the diffstat and shortlog instead
of a pack?  It has all information needed for that, after all...

I mean, _you_ can ask that sort of summary, but when somebody else
wants to take a look at the summary of some branch in remote repository
mentioned on l-k, well...

If that's too much work server-side, could the result of git-fetch-pack -k
be easily postprocessed client-side to get the same result?  That's
easy to undo - just a single rm would do that...
