Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131365AbRC1OoM>; Wed, 28 Mar 2001 09:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131409AbRC1OoD>; Wed, 28 Mar 2001 09:44:03 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:37705 "EHLO tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP id <S131365AbRC1Onv>; Wed, 28 Mar 2001 09:43:51 -0500
Date: Wed, 28 Mar 2001 08:43:01 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103281443.IAA42752@tomcat.admin.navo.hpc.mil>
To: rmk@arm.linux.org.uk, Jesse Pollard <jesse@cats-chateau.net>
Subject: Re: Disturbing news..
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Wed, Mar 28, 2001 at 06:08:15AM -0600, Jesse Pollard wrote:
> > Sure - very simple. If the execute bit is set on a file, don't allow
> > ANY write to the file. This does modify the permission bits slightly
> > but I don't think it is an unreasonable thing to have.
> 
> Even easier method - remove the write permission bits from all executable
> files, and don't do the unsafe thing of running email/web browsers/other
> user-type stuff as user root.
> 
> If it still worries you that root can write to files without the 'w' bit
> set, modify the capabilities of the system to prevent it (there is a bit
> that can be set which will remove this ability for all new processes).

How about just adding MLS ... :-)

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
