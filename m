Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132045AbRC1PcM>; Wed, 28 Mar 2001 10:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132044AbRC1PcD>; Wed, 28 Mar 2001 10:32:03 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:60745 "EHLO tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP id <S132033AbRC1Pbz>; Wed, 28 Mar 2001 10:31:55 -0500
Date: Wed, 28 Mar 2001 09:31:01 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103281531.JAA46448@tomcat.admin.navo.hpc.mil>
To: sean@dev.sportingbet.com, Jesse Pollard <jesse@cats-chateau.net>
Subject: Re: Disturbing news..
Cc: Shawn Starr <spstarr@sh0n.net>, Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter <sean@dev.sportingbet.com>:
> On Wed, Mar 28, 2001 at 06:08:15AM -0600, Jesse Pollard wrote:
> > Sure - very simple. If the execute bit is set on a file, don't allow
> > ANY write to the file. This does modify the permission bits slightly
> > but I don't think it is an unreasonable thing to have.
> > 
> 
> Are we not then in the somewhat zen-like state of having an "rm" which can't
> "rm" itself without needing to be made non-executable so that it can't execute?

We've been in that state for a long time... (carefull updating that libc.so
file... can't overwrite/delete without having some REAL problems show up.)

It just calls for some carefull activity. If rm is being replaced, first
rename it; then put new one in place; chmod old; delete old. It is directly
comparable to the libc.so update procedure.

I should have left off the "very simple" remark.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
