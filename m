Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTEHShg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbTEHShg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 14:37:36 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:34040 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261878AbTEHShf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 14:37:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The disappearing sys_call_table export.
Date: Thu, 8 May 2003 13:28:05 -0500
X-Mailer: KMail [version 1.2]
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
References: <200305081009_MC3-1-37FA-2408@compuserve.com> <03050809564900.09057@tabby> <1052407341.10038.69.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1052407341.10038.69.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Message-Id: <03050813280502.09468@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 May 2003 10:22, Alan Cox wrote:
[snip]
> > Fix the vulnerability. Then there won't be a virus.
>
> But you don't know if its fixed and if there are any more holes without
> being able to detect attackers be they electronic or human.

Detecting attackers is a different situation. An attack that is already fixed
is not a serious problem other than bandwidth. Virus scanners can't do that
anyway - they can only detect what has already been detected... and which
should have been fixed by the time the signature could have been put out,
anyway. Detection should be part of an intrusion facility (isn't LIDS supposed
to do that?)

Second, I want to setup SELinux to sandbox various facilities anyway (delayed 
due to job change). That should isolate any unknown attack to just one
service, and protect the overall system.
