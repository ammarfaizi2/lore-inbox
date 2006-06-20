Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWFTEfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWFTEfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 00:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWFTEfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 00:35:36 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:52071 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964899AbWFTEff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 00:35:35 -0400
X-IronPort-AV: i="4.06,153,1149490800"; 
   d="scan'208"; a="1828855215:sNHT32274104"
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
X-Message-Flag: Warning: May contain useful information
References: <44954102.3090901@s5r6.in-berlin.de>
	<Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
	<20060620025552.GO27946@ftp.linux.org.uk>
	<Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
	<20060620042250.GP27946@ftp.linux.org.uk>
	<20060620043148.GQ27946@ftp.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 19 Jun 2006 21:35:31 -0700
In-Reply-To: <20060620043148.GQ27946@ftp.linux.org.uk> (Al Viro's message of "Tue, 20 Jun 2006 05:31:48 +0100")
Message-ID: <adar71kphpo.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Jun 2006 04:35:31.0809 (UTC) FILETIME=[F6DC9D10:01C69422]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Actually, posting that _was_ useful - staring at the above got me to
 > realize that git clone -l -s -n + git fetch + git log + rm -rf would
 > work just fine and be much faster than the variant above...
 > 
 > Still, that looks like excessive from server, if nothing else.  Is there
 > a better way to do it?  Getting remote log, that is, preferably with
 > a way to get it starting at the point I have in local tree.

In the same vein "git clone --reference <local tree> <remote>" would
be a further optimization, I think.

 - R.
