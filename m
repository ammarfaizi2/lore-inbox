Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVHBXGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVHBXGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 19:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVHBXGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 19:06:43 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:46887 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261909AbVHBXGk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 19:06:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SlJgTE3ew3VAtRkxEcW0fOBd9Pvv6BwPyf0kM++ldnxOf7tDcNpqCQUDOk5gBxmaTUs5iDa5hl5ykNimzADIb0AJnNJK1rRvIEciU8Wox5K3wfSA5SANRhznJNB5NuDWHuFGKVvj1RksPCkXC28z7JYKHJzJHW4TcKYaa0GU8RE=
Message-ID: <a728f9f90508021606e3cf975@mail.gmail.com>
Date: Tue, 2 Aug 2005 19:06:34 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: strange issues with JFS on sparc64
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, ag@m-cam.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 7 TB JFS volume on a sparc64 box (sun enterprise 220R)
running 2.6.12.2 on debian sparc.   When copying large numbers of
files, files start to dissappear, but they are not actually gone they
just stop showing up.  when you delete enough files from the
directory, all of a sudden all of the remaining files show up.  If I
try and run an fsck on the volume I get a bus error.  It seems to be
an issue with JFS on sparc64 as I have the same setup on AMD64 with no
problems.  I talked to some of the IBM engineers and it seems like it
may be an alignment problem on SPARC64.  I was hoping someone with
more experience with SPARC hardware may have some input that could
help us solve the problem.
The full thread is here:
http://sourceforge.net/mailarchive/forum.php?thread_id=7852301&forum_id=43911

Any insight is much appreciated.

Thanks,

Alex
