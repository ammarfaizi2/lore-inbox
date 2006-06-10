Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWFJPDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWFJPDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 11:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWFJPDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 11:03:25 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37051 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751105AbWFJPDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 11:03:24 -0400
Message-ID: <448ADF32.3070705@garzik.org>
Date: Sat, 10 Jun 2006 11:03:14 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Adrian Bunk <bunk@stusta.de>, Gerrit Huizenga <gh@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org> <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com> <20060610134645.GB11634@stusta.de> <20060610144228.GA6416@elte.hu>
In-Reply-To: <20060610144228.GA6416@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the ext3 -> ext4 patches add +2115 lines of code (which 2115 lines solve 
> the biggest performance and scaling problem ext3 currently has), which 
> is 1.9% of the linecount of XFS.

Indeed!


> ext3 does quite a few things to stay compatible with ext2 - and frankly, 
> i very much expected it to do that when i migrated my ext2 data to ext3. 
> The days of "change the world in an incompatible way and dont look back" 
> are gone.

I agree with your point in the thread -- most users and distros don't 
change their main fs on a whim.  But I also point out that these 
extent+48bit changes _do_ change the format in an incompatible way...

	Jeff


