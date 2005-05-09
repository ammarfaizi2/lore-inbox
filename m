Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVEIRhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVEIRhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVEIRhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:37:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27802 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261453AbVEIRhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:37:03 -0400
Subject: Re: Two oops reports
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Jay Salzman <p@dirac.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050509172435.GA6826@dirac.org>
References: <20050509172435.GA6826@dirac.org>
Content-Type: text/plain
Date: Mon, 09 May 2005 13:37:00 -0400
Message-Id: <1115660221.8156.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 13:24 -0400, Peter Jay Salzman wrote:
> I've never sent in an oops report before.  From oops-tracing.txt, man
> ksymoops and the ksymoops output, I need /proc/ksyms, but it appears that
> file has disappeared from the kernel.  However, judging by the actual text
> of the oops report, it appears that the object translation was performed
> automatically.  I'm seeing things that look like function names, so perhaps
> the man page, oops-tracing.txt, and ksymoops output are all out of date?

Yes, they are.  I finally posted a patch which corrects the docs, post
2.6.11.

Anyway these two traces appear to have nothing to do with one another.
Random Oopses like this usually indicate failing hardware.  Try memtest.

Lee

