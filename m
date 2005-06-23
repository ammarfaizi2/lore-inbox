Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVFWCZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVFWCZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFWCW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:22:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31156 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261984AbVFWCVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:21:21 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com> <20050621132204.1b57b6ba.akpm@osdl.org>
	<m1fyvamiyu.fsf@ebiederm.dsl.xmission.com>
	<20050622135235.038b5222.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Jun 2005 20:14:36 -0600
In-Reply-To: <20050622135235.038b5222.akpm@osdl.org>
Message-ID: <m1y891lsz7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > Andrew the good news is unless something comes up I will have time
> > starting about Monday to help with the 2.6.13 merge.  It looks like
> > the first thing I should do is split up the indent patch so it pairs
> > well with the rest.  And then I have a few pending patches for the user
> > space and I think I can fix a number of the device_shutdown problems,
> > for at least the normal kexec path.
> 
> I'd be inclined to leave it as-is, really.  I'm not sure that it's worth
> the effort+risk of significantly refactoring the patches.
> 
> I've cut it down from 58 patches to 45 and will take another pass at it in
> the next day or two, but it's looking like 40-odd patches is the right
> number.

Ok.  Then I won't put a priority on that piece.

I will still look at cleaning up the sematics of the reboot
path so fewer things break.

Eric

