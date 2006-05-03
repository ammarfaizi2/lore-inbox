Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWECMLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWECMLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWECMLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:11:41 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:11917 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965170AbWECMLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:11:31 -0400
Date: Wed, 3 May 2006 08:11:29 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem while applying patch to 2.6.9 kernel
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAwZsyZCSXbUSO0mznjdzGqgEAAAAA@spsoftindia.com>
Message-ID: <Pine.LNX.4.58.0605030809100.24221@gandalf.stny.rr.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAwZsyZCSXbUSO0mznjdzGqgEAAAAA@spsoftindia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 May 2006, Yogesh Pahilwan wrote:

> Hi Kernel Folks,
>
> I am facing some problem while applying patch to the 2.6.9 kernel.
>
> I have done following to apply the patch:
>
> # patch -p1 < ../../Patches/patch-ext3
>
> But getting following things:
>
> missing header for unified diff at line 3 of patch
> (Stripping trailing CRs from patch.)
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?

Hmm, perhaps you have the wrong -p option.

> The text leading up to this was:
> --------------------------
> |#--- ../A_CLEAN_FILE_SYSTEM/jbd/commit.c       2006-02-25

Since you didn't show us any of this patch, the above looks like you need
-p2.

You might want to get yourself more familiar with "patch".

-- Steve


> 11:43:19.000000000 -0600
> |#+++ commit.c  2006-03-29 20:53:29.000000000 -0600
> --------------------------
> File to patch:
>
> Can anyone suggest what I am doing wrong while applying this patch or if the
> command is correct then why patch is giving the above errors.
>
> Any help can be greatly appreciated.
>
> Thanks,
> Yogesh
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
