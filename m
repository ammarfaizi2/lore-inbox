Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWBHBGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWBHBGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWBHBGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:06:07 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:2482 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1030351AbWBHBGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:06:05 -0500
Message-ID: <43E943FD.7090508@tlinx.org>
Date: Tue, 07 Feb 2006 17:06:05 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: File "Changelog-2.6.15": missing signoffs
References: <43E935BA.8050605@tlinx.org>
In-Reply-To: <43E935BA.8050605@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, ("talking" to myself?), parsing this file a bit more,
I find many (~134) that are missing "Sign-offs".

I take it that "Sign-off"s are also "optional" on commits
and represent that the author specified under the "commit"
tag did not need a "Sign-off"?

Just trying to see if I can parse large changelogs into groups
that might be easier digest and summarize...

-linda


Linda Walsh wrote:
> I was examining and checking the Changelog for 2.6.15 and noticed
> one commit out of the 4959 that was problematic (near line 21375):
>
> commit 7b7abfe3dd81d659a0889f88965168f7eef8c5c6
> Author: Steve French <sfrench@us.ibm.com>
> Date:   Wed Nov 9 15:21:09 2005 -0800
>
> --- end of entry ---
>
> This change has no description and no one listed as signing it off.
>
> Was there a 1-line description for this commit and was this
> commit sign off by anyone?
>
> Do either, the missing "signoff", or "description", constitute the
> possibility that the "commit" went in "unapproved" & "unaudited"?
>
>
> On a less worrisome note, 62 of the 4958 commits had no "details"
> beyond (after) the 1-line description. Is it safe to say that further
> "details" after the 1-line description are optional?
>
> This is the first Changelog I've examined in this detail, so I can't
> say if this is a first or one-time problem.
>
> Thanks,
> -linda
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
