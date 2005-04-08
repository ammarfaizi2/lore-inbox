Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVDHDmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVDHDmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVDHDmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:42:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54147 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262668AbVDHDln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:41:43 -0400
Message-ID: <4255FD66.7060803@pobox.com>
Date: Thu, 07 Apr 2005 23:41:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org> <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0504071038320.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504071038320.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Warning: 24.25.22.197 is listed at orbz.gst-group.uk.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In other words, this cherry-picking can generally be scripted and done
> "outside" the SCM (you can trivially have a script that takes a revision
> from one tree and applies it to the other). I don't believe that the SCM
> needs to support it in any fundamentally inherent manner. After all, why 
> should it, when it really boilds down to 
> 
> 	(cd old-tree ; scm export-as-patch-plus-comments) |
> 		(cd new-tree ; scm import-patch-plus-comments)
> 
> where the "patch-plus-comments" part is just basically an extended patch
> (including rename information etc, not just the comments).


Not that it matters anymore, but that's precisely what the script
	Documentation/BK-usage/cpcset
did, for BitKeeper.

	Jeff


