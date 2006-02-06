Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWBFLJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWBFLJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWBFLJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:09:43 -0500
Received: from mail.suse.de ([195.135.220.2]:24037 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932076AbWBFLJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:09:42 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Mahoney <jeffm@suse.com>,
       LKML <linux-kernel@vger.kernel.org>, kernel-bugzilla@luksan.cjb.net
Subject: Re: quality control
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com>
	<43E6BF48.5010301@namesys.com>
	<BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Feb 2006 12:09:27 +0100
In-Reply-To: <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com>
Message-ID: <p73hd7clp5k.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:
> 
> It's a GIT version of an RC patch for grief's sake!  You don't
> seriously expect people to quadruple-check every trivial patch that
> goes into Linus GIT tree before sending it, do you? 

No quadruple check, but every patch going to Linus should get at least
some basic testing and it's definitely suppose to compile at least
in one .config combination.

> The whole point
> of the RC is to indicate that only smaller patches should be applied
> (and this one was for the most part) so that we can do some kind of
> global-kernel QC.

global kernel QA doesn't replace individual patch QA. Black box 
testing is no replacement for targetted tests.

-Andi
