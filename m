Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVFRU0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVFRU0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 16:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVFRU0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 16:26:40 -0400
Received: from serv4.servweb.de ([82.96.83.76]:33956 "EHLO serv4.servweb.de")
	by vger.kernel.org with ESMTP id S262245AbVFRU0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 16:26:32 -0400
Date: Sat, 18 Jun 2005 22:26:24 +0200
From: Patrick Plattes <patrick@erdbeere.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optimization for sys_semtimedop() (was: Opening Day for OpenSolaris)
Message-ID: <20050618202624.GA11512@erdbeere.net>
References: <42AF12A8.4060007@colorfullife.com> <42AFB94D.5010603@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AFB94D.5010603@colorfullife.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 07:14:53AM +0200, Manfred Spraul wrote:
 
> Jim: From my understanding of the CDDL, only a file that "contains any 
> part of the Original Software" must be licensed under the CDDL, there 
> are no restrictions (except possibly patents, but I assume that even the 
> USPTO won't grant a patent on such a trivial idea) on using methods or 
> ideas from OpenSolaris in software that uses other licenses.
> Is that correct?

Hello,

Patch: The patch looks fine and compiles clean.

CDDL: What is the definition of 'part'? IMHO we need a debate how to
work with OpenSolaris ideas and the debate must me done by lawyers, 
not by kernel hacker.

Other: sem.c is hard to read - for me. Long functions and a lot of
gotos confusing me. is this only my problem or is it really hard to
understand?

cu
pp
