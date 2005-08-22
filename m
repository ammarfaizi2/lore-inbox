Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVHVXIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVHVXIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVHVXIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:08:13 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64143 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932322AbVHVXIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:08:10 -0400
Date: Sun, 21 Aug 2005 21:06:06 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, samba@samba.org,
       linux-kernel@vger.kernel.org, Urban.Widmark@enlight.net,
       Steven French <sfrench@us.ibm.com>
Subject: Re: New maintainer needed for the Linux smb filesystem
Message-ID: <20050822010606.GA20833@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	samba@samba.org, linux-kernel@vger.kernel.org,
	Urban.Widmark@enlight.net, Steven French <sfrench@us.ibm.com>
References: <20050821143457.GA5726@stusta.de> <20050821124657.22f1a095.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821124657.22f1a095.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 12:46:57PM -0700, Andrew Morton wrote:
 > Adrian Bunk <bunk@stusta.de> wrote:
 > >
 > > Since Urban Widmark was not active for some time, and I didn't have any 
 > > success trying to reach him, it seems we need a new maintainer for the 
 > > smb filesystem in the Linux kernel.
 > > 
 > > Is there anyone who both feels qualified and wants to become the new 
 > > maintainer?
 > 
 > Yes, it's a poor situation.  That driver seems to have quite a few problems.
 > 
 > I was hoping that by now we could simply deprecate smbfs and tell people to
 > use CIFS, but I'm not sure that CIFS is ready for that yet.
 > 
 > Steve, what's your take?  Does CIFS offer a 100% superset of smbfs
 > capabilities?

A while ago, we disabled it in Fedora kernels, and told people
"Use CIFS instead".  There were a whole range of Windows variants
that it couldn't talk to.  Maybe the situation has improved since,
but at the time, it was bad enough that we had to switch smbfs back on.

		Dave

