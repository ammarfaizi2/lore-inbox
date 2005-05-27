Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVE0STX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVE0STX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVE0STW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:19:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:40384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262515AbVE0SS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:18:57 -0400
Date: Fri, 27 May 2005 11:20:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.11.11
In-Reply-To: <20050527180711.GH27549@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0505271117290.17402@ppc970.osdl.org>
References: <20050527160437.GL23013@shell0.pdx.osdl.net> <1117213882.13829.73.camel@mindpipe>
 <20050527180711.GH27549@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Chris Wright wrote:
> 
> Yes, you are right, the git commit scripts culled that author info from
> the person who submitted it to -stable.

Side note: the patch-applicator scripts will, if the first line of the
email body is of the form "^From: xxxx", and there's exactly one '@' sign
on that line, then it will assume that it's supposed to be the author
info, and use that instead of the "From: " line in the header of the
email.

So when passing on stuff from others, that's always the preferred way to 
do it. A lot of people already follow this convention, and it might even 
be documented somewhere.

			Linus
