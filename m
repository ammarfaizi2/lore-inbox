Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270464AbTGNAIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270462AbTGNAIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:08:35 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:53452 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270464AbTGNAIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:08:31 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: Nathan Scott <nathans@sgi.com>
Subject: Re: 2.5.75 and xfs quotas
Date: Sun, 13 Jul 2003 18:32:39 -0400
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200307131025.56438.ivg2@cornell.edu> <20030713234837.GA891@frodo>
In-Reply-To: <20030713234837.GA891@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131832.39596.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There will be a more meaningful message in your system log.

There is...quota is unsupported. But I figured that out from the rest of it.

> This (remount,quota) is not implemented by the XFS kernel code,
> and hasn't ever been, although there was a time when it wouldn't
> have reported an error when attempting this.  Currently, quota
> can only be enabled during the initial mount.  For your root fs
> this means using "rootflags=quota" during startup.

Okay, thank you. 
Perhaps that's what the warning should say rather than "quota option 
unsupported"?




