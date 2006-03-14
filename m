Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWCNOBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWCNOBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWCNOBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:01:08 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:5263 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750723AbWCNOBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:01:07 -0500
Date: Tue, 14 Mar 2006 08:57:33 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Development tree, PLEASE?
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200603140900_MC3-1-BA9A-44CC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060202221023.GJ11831@redhat.com>

On Thu, 2 Feb 2006 17:10:25 -0500, Dave Jones wrote:

> -rw-r--r--    1 davej    davej        1686 Dec 15 23:31 linux-2.6-build-userspace-headers-warning.patch
> 
> adds a #error to includes if __KERNEL__ isn't being used
> (We want people to use the headers from our glibc-kernheaders package,
> not from the kernel soucre).

 Red Hat's headers are way out of date.

 Just try compiling this using FC4's latest kernheaders:

        ptrace(PTRACE_SETOPTIONS, child, NULL, PTRACE_O_TRACEFORK);

 PTRACE_O_TRACEFORK is undefined.

 No wonder people use kernel headers despite being told not to.

-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

