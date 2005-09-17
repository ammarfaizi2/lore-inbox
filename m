Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVIQAIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVIQAIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVIQAIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:08:15 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:31923 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750776AbVIQAIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:08:15 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: rolandd@cisco.com, viro@ftp.linux.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] utterly bogus userland API in infinibad
X-Message-Flag: Warning: May contain useful information
References: <52fys4lsh9.fsf@cisco.com>
	<20050916203724.GH19626@ftp.linux.org.uk> <52psr8k1qg.fsf@cisco.com>
	<20050916.170349.72543699.davem@davemloft.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Sep 2005 17:08:06 -0700
In-Reply-To: <20050916.170349.72543699.davem@davemloft.net> (David S.
 Miller's message of "Fri, 16 Sep 2005 17:03:49 -0700 (PDT)")
Message-ID: <52d5n8k13t.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 17 Sep 2005 00:08:08.0027 (UTC) FILETIME=[E202C2B0:01C5BB1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Read the unix(7) man page, section ANCILLARY MESSAGES,
    David> sub-section SCM_RIGHTS, to see how userspace can use this
    David> stuff between processes.

Yeah, I know about using SCM_RIGHTS between processes in userspace...

    David> Yes, you could open up an AF_UNIX socket with userspace and
    David> pass the FDs over via SCM_RIGHTS.

...but how does the kernel open an AF_UNIX socket with userspace?

 - R.
