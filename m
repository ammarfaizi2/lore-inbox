Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWECMaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWECMaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWECMaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:30:52 -0400
Received: from smtpauth00.csee.siteprotect.com ([64.41.126.131]:60292 "EHLO
	smtpauth00.csee.siteprotect.com") by vger.kernel.org with ESMTP
	id S965173AbWECMav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:30:51 -0400
From: "Yogesh Pahilwan" <pahilwan.yogesh@spsoftindia.com>
To: "'Steven Rostedt'" <rostedt@goodmis.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Problem while applying patch to 2.6.9 kernel
Date: Wed, 3 May 2006 18:02:45 +0530
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA/RwgNB/GzEaFbUDhx3/9tAEAAAAA@spsoftindia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <Pine.LNX.4.58.0605030809100.24221@gandalf.stny.rr.com>
Thread-Index: AcZuq1HzhDTOHQBCTaqEYv3SGOWX+gAAg+HQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I tried specifying -p2 as follows:

# patch -p2 < ../../Patches/patch-ext3

But still getting the same error.

Please suggest.

Thanks,
Yogesh

-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: Wednesday, May 03, 2006 5:41 PM
To: Yogesh Pahilwan
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem while applying patch to 2.6.9 kernel


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
> Can anyone suggest what I am doing wrong while applying this patch or if
the
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

