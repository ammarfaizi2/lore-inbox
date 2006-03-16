Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWCPUl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWCPUl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWCPUl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:41:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964850AbWCPUl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:41:56 -0500
Date: Thu, 16 Mar 2006 12:41:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
In-Reply-To: <20060316123341.0f55fd07.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603161240330.3618@g5.osdl.org>
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com> <20060316123341.0f55fd07.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2006, Andrew Morton wrote:
> 
> iirc there was some discussion about this and it was explicitly decided to
> keep the CLONE flags.
> 
> Maybe Janak or Linus can comment?

My personal opinion is that having a different set of flags is more 
confusing and likely to result in problems later than having the same 
ones. Regardless, I'm not touching this for 2.6.16 any more, 

		Linus
