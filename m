Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272544AbTGZP2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270148AbTGZPZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:25:19 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:24207 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S270143AbTGZPWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:22:07 -0400
Date: Sat, 26 Jul 2003 17:37:09 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Eli Barzilay <eli@barzilay.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Repost: Bug with select?
Message-ID: <20030726153709.GA29382@localhost>
References: <20030725134155.GA19211@localhost> <3F21C93D.6000005@candelatech.com> <20030726090523.GA25539@localhost> <16112.10166.989608.288954@mojave.cs.cornell.edu> <16159.28266.868297.372200@mojave.cs.cornell.edu> <16162.36685.970735.562244@mojave.cs.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16162.36685.970735.562244@mojave.cs.cornell.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op Saturday 26 July 2003 at 10:25 Eli Barzilay wrote:

> ...

> I just added that when trying to trace the problem and reading
> somewhere that ISSET must be used...  It never had any effect -- never
> exits and otherwise the program is still on a busy spin in Linux and
> fine on Solaris.

After some more testing the behaviour here seems indeed a bit odd. For
what it's worth I just tested the program under IBM AIX 4.2 on an old
RS/6000 machine, and it doesn't busy spin there either.
-- 
Marco Roeland
