Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbVCEGGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbVCEGGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbVCEGBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:01:45 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:20598 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263168AbVCEF57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 00:57:59 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Greg K-H <greg@kroah.com>
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Date: Sat, 5 Mar 2005 00:57:42 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <11099685952869@kroah.com>
In-Reply-To: <11099685952869@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503050057.44233.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does this fit into Rusty's trivial patch bot?  This process will fold that 
into a formal method now?

Shawn.

> List:       linux-kernel
> Subject:    [RFQ] Rules for accepting patches into the linux-releases tree
> From:       Greg KH <greg () kroah ! com>
> Date:       2005-03-04 22:21:46
> Message-ID: <20050304222146.GA1686 () kroah ! com>
> [Download message RAW]
> 
> Anything else anyone can think of?  Any objections to any of these?
> I based them off of Linus's original list.
> 
> thanks,
> 
> greg k-h
> 
> ------
> 
> Rules on what kind of patches are accepted, and what ones are not, into
> the "linux-release" tree.
> 
>  - It can not bigger than 100 lines, with context.
>  - It must fix only one thing.
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing.)
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
>  - No "theoretical race condition" issues, unless an explanation of how
>    the race can be exploited.
>  - It can not contain any "trivial" fixes in it (spelling changes,
>    whitespace cleanups, etc.)
