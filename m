Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVCVFUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVCVFUX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVCVFQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:16:30 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57321 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262364AbVCVFP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:15:56 -0500
Subject: Re: kernel bug: futex_wait hang
From: Lee Revell <rlrevell@joe-job.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Chris Morgan <cmorgan@alum.wpi.edu>, paul@linuxaudiosystems.com,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
In-Reply-To: <20050322044838.GB32432@mail.shareable.org>
References: <1111463950.3058.20.camel@mindpipe>
	 <20050321202051.2796660e.akpm@osdl.org>
	 <20050322044838.GB32432@mail.shareable.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 00:15:49 -0500
Message-Id: <1111468549.3058.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 04:48 +0000, Jamie Lokier wrote:
> I argued for fixing Glibc on the grounds that the changed kernel
> behaviour, or more exactly having Glibc depend on it, loses a certain
> semantic property useful for unusual operations on multiple futexes at
> the same time.  But I appear to have lost the argument, and Jakub's
> latest patch does clean up some cruft quite nicely, with no expected
> performance hit.

A glibc fix will take forever to get to users compared to a kernel fix.

Lee

