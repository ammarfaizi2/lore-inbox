Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVC2E7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVC2E7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 23:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVC2E7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 23:59:22 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39581 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261574AbVC2E7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 23:59:16 -0500
Subject: Re: [RFC/PATCH 0/17][Kdump] Overview
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20050328174827.414a90a9.akpm@osdl.org>
References: <1112016341.4001.71.camel@localhost.localdomain>
	 <20050328174827.414a90a9.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 10:29:13 +0530
Message-Id: <1112072354.3604.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 17:48 -0800, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> >  Following patches (as in series file) need to be dropped before applying
> >  the fresh ones.
> > 
> >  crashdump-documentation.patch
> >  crashdump-memory-preserving-reboot-using-kexec.patch
> >  crashdump-routines-for-copying-dump-pages.patch
> >  crashdump-routines-for-copying-dump-pages-fixes.patch
> >  crashdump-elf-format-dump-file-access.patch
> >  crashdump-linear-raw-format-dump-file-access.patch
> >  crashdump-linear-raw-format-dump-file-access-coding-style.patch
> 
> At some point we should stop tossing out patches and replacing them in this
> manner.


Andrew, I shall take care of sending incremental patches only next time
onwards. The reason why I did this because changes were relatively large
and I thought dropping the existing series and replacing it with new
series (some patches retaining the old name) might be a better idea.


> Because doing so makes it hard for people to see what has changed.  
> 
> It makes it hard for people to see that changes in the above patches
> haven't been simply lost.
> 
> And the fact that you were probably working against some kernel other than
> -mm gives little confidence that the kdump development team have been
> testing the patches which are presently in -mm.  And that is what they are
> there for.
> 
> 
> 

