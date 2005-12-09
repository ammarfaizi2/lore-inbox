Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVLIOe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVLIOe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVLIOe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:34:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38571 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751055AbVLIOe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:34:59 -0500
Date: Fri, 9 Dec 2005 14:34:45 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: JANAK DESAI <janak@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/5] New system call, unshare
Message-ID: <20051209143445.GM27946@ftp.linux.org.uk>
References: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com> <20051209105502.GA20314@elte.hu> <20051209120244.GL27946@ftp.linux.org.uk> <43999199.70608@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43999199.70608@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 09:15:53AM -0500, JANAK DESAI wrote:
> To answer Ingo's question, we did look at other flags when I started. 
> However,
> I wanted to keep the system call simple enough, with atleast namespace 
> unsharing,
> so it would get accepted. In the original discussion on fsdevel, 
> unsharing of vm
> was mentioned as useful so I added that in addition to namespace unsharing.

So make that a series...  Note that it can be merged gradually - adding
and debugging the unsharing of fs, files, etc. can be done independently
and with no ABI changes.
