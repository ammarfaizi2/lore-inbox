Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbTIKUuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTIKUuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:50:04 -0400
Received: from mail1-106.ewetel.de ([212.6.122.106]:24518 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S261540AbTIKUuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:50:01 -0400
To: Kyle Rose <krose+linux-kernel@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
In-Reply-To: <uGoz.5NC.7@gated-at.bofh.it>
References: <uGoz.5NC.7@gated-at.bofh.it>
Date: Thu, 11 Sep 2003 22:49:42 +0200
Message-Id: <E19xYNq-0001Iu-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 22:40:11 +0200, you wrote in linux.kernel:

> However, just as the write completed, the beginning of the file became
> corrupted.  I considered a 4GB problem to be likely, and re-tested
> with fewer source files such that the result would be smaller than
> 4GB; lo and behold, no corruption.  The same result occurs whether
> mkisofs is given the -o flag, or output is redirected to a file from
> stdout using the shell's redirection facility, suggesting the problem
> is probably at the kernel level.

Could also be that your mkisofs is not compiled with large file
support.

-- 
Ciao,
Pascal
