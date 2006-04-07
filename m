Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWDGTBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWDGTBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWDGTBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:01:51 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:18348 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964889AbWDGTBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:01:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DFmJij+kFAzJYYGQRDylMaOiTJyamW9ydNz+34qGCwnPdVWUezJGxNHTuVEwDmh9d4wEg5JRazsfm37dFEUm2HeMsMGf+4mpqj2cmkVffEy3C9oOKz7zPhTLB1t/tkpr0iXO+mkhrHCpkNtmEm9ojW1/mhJ9ZVy9NhFqAAPIRnM=
Message-ID: <bda6d13a0604071201h64bfab2av21c8c3e0bbd8af0d@mail.gmail.com>
Date: Fri, 7 Apr 2006 12:01:49 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] Add a /proc/self/exedir link
In-Reply-To: <bda6d13a0604071201o36496a55o2eae6a65153a06c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5XGlt-GY-23@gated-at.bofh.it> <5XGOz-1eP-35@gated-at.bofh.it>
	 <E1FRSqP-0000g3-9i@be1.lrz> <443515E1.1000600@plan99.net>
	 <Pine.LNX.4.58.0604061841150.1941@be1.lrz> <44356DAA.90209@plan99.net>
	 <m164llns9p.fsf@ebiederm.dsl.xmission.com>
	 <bda6d13a0604071201o36496a55o2eae6a65153a06c3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also there is a very serious problem with suid exectuables.
> If a non privileged user has write access to the same filesystem
> the exectuables live on they can create a hard link to those
> files and change the prefix.  Quite possibly getting the suid
> executables to trust a new set of exectuables.

Excellent point. This proposal needs to die, but there needs to be some way
to solve this problem.
