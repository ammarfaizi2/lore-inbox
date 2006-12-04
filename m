Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935774AbWLDKwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935774AbWLDKwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935842AbWLDKwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:52:39 -0500
Received: from fogou.chygwyn.com ([195.171.2.24]:35289 "EHLO fogou.chygwyn.com")
	by vger.kernel.org with ESMTP id S935774AbWLDKwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:52:38 -0500
Subject: Re: What's in ocfs2.git
From: Steven Whitehouse <steve@chygwyn.com>
To: Valerie Henson <val_henson@linux.intel.com>,
       Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
In-Reply-To: <20061203203149.GC19617@ca-server1.us.oracle.com>
References: <20061203203149.GC19617@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: ChyGwyn Limited
Date: Mon, 04 Dec 2006 10:54:53 +0000
Message-Id: <1165229693.3752.629.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "fogou.chygwyn.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sun, 2006-12-03 at 12:31 -0800, Mark Fasheh
	wrote: > This e-mail describes the OCFS2 patches which I intend to push
	> upstream to Linus for 2.6.20. > > * Atime updates - thanks to Tiger
	Yang <tiger.yang@oracle.com>, ocfs2 now > writes to the inode atime
	field. This doesn't require any disk changes, > and is completely
	backwards compatible with older ocfs2 versions. An > inodes Atime is
	only updated if it hasn't changed within a certain > quantum. The user
	can define their own value at mount time, with 0 > indicating that atime
	should always be updated. This is very similar to > the scheme
	implemented by gfs2. In the future, I'd like to see a "relative > atime"
	mode, which functions in the manner described by Valerie Henson at: > >
	http://lkml.org/lkml/2006/8/25/380 > I'd like to second that. [adding
	Val Henson to the "to"] What (if anything) remains to be done before the
	relative atime patch is ready to go upstream? I'm happy to help out here
	if required, [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-12-03 at 12:31 -0800, Mark Fasheh wrote:
> This e-mail describes the OCFS2 patches which I intend to push
> upstream to Linus for 2.6.20.
> 
> * Atime updates - thanks to Tiger Yang <tiger.yang@oracle.com>, ocfs2 now
>   writes to the inode atime field. This doesn't require any disk changes,
>   and is completely backwards compatible with older ocfs2 versions. An
>   inodes Atime is only updated if it hasn't changed within a certain
>   quantum. The user can define their own value at mount time, with 0
>   indicating that atime should always be updated. This is very similar to
>   the scheme implemented by gfs2. In the future, I'd like to see a "relative
>   atime" mode, which functions in the manner described by Valerie Henson at:
> 
> http://lkml.org/lkml/2006/8/25/380
> 
I'd like to second that. [adding Val Henson to the "to"] What (if
anything) remains to be done before the relative atime patch is ready to
go upstream? I'm happy to help out here if required,

Steve.


