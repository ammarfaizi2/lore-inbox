Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVH2OvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVH2OvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 10:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVH2OvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 10:51:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750975AbVH2OvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 10:51:10 -0400
Date: Mon, 29 Aug 2005 07:50:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: ncunningham@cyclades.com, Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13
In-Reply-To: <43131AE9.7010802@gmail.com>
Message-ID: <Pine.LNX.4.58.0508290744460.3243@g5.osdl.org>
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org> 
 <1125313050.5611.11.camel@localhost.localdomain> <1125317850.6496.7.camel@localhost>
 <43131AE9.7010802@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, Antonino A. Daplas wrote:
> 
> Both, actually, with exactly the same patch.  In the long changelog, both 
> Steven and Paul are co-signees but only Paul's name appeared in the short 
> changelog.

git only has one author field. That's not really technically fundamental
(git could be extended to have multiple authors), but it's pretty
fundamental to the work-flow, so in 99% of all cases nothing else makes
sense.

IOW, when I got around to applying the patch, I had two emails with the
same patch to apply, and I picked Paul's explanation and added commentary
about Steven doing the exact same thing in the longer log entry.

I _could_ also have applied both (in different branches) and merged the
two, but since that's not only about three times the work, but also 
against my normal workflow, and I'm lazy...

			Linus
