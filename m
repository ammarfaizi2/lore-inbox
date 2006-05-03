Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWECMni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWECMni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWECMni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:43:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965185AbWECMng convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:43:36 -0400
Date: Wed, 3 May 2006 05:43:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org, MEDER@de.ibm.com,
       RAISCH@de.ibm.com, HNGUYEN@de.ibm.com, schickhj@de.ibm.com
Subject: Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
Message-Id: <20060503054312.b3978297.akpm@osdl.org>
In-Reply-To: <20060427125726.GK32127@wohnheim.fh-wedel.de>
References: <4450B378.9000705@de.ibm.com>
	<20060427125726.GK32127@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 14:57:26 +0200
Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Don't expect much cheer and rejoicing over this.  I suspect that akpm
> or Linus will either want the 17 patches merged into one or have a
> patchset where every single patch leaves the kernel in a working
> state, including working eHCA driver.

It doesn't matter in this case.  The "don't break the build at any stage of
a series" preference exists because it's extremely irritating to hit a
won't-build in the middle of a git-bisect operation.

But anybody who is bisection searching for a bug won't want to enable a
brand-new driver in their config, so no problems.
