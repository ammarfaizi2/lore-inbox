Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUIJKGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUIJKGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIJKGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:06:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49319 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266560AbUIJKGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:06:13 -0400
Subject: Re: linux-2.6.9-rc1-bk16 Still cdrom/DVD oops
From: Lee Revell <rlrevell@joe-job.com>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4140FC70.1070101@blueyonder.co.uk>
References: <4140F3A7.8040103@blueyonder.co.uk>
	 <1094776333.1396.31.camel@krustophenia.net>
	 <4140FC70.1070101@blueyonder.co.uk>
Content-Type: text/plain
Message-Id: <1094810774.15407.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 06:06:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 20:59, Sid Boyce wrote:
> Lee Revell wrote:
> >Your kernel is tainted.  Please reproduce with an untainted kernel and
> >report.
> >
> The only tainted module is "nvidia", the results are the same without 
> that module loaded in -bk15, i.e in runlevel 3. I've seen this problem 
> on all kernels from 2.6.8.1 including -mm?. It's fine with 
> 2.6.8-rc4-mm1, the earliest kernel I currently have around.

Understood.  No one is suggesting the nvidia module caused the Oops,
it's just that as long as there's a binary module loaded, the Oops can't
be interpreted fully.

If you can reproduce without nvidia loaded, then post one of these.

Lee

