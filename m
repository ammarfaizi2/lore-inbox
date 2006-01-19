Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161283AbWASTFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWASTFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbWASTFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:05:20 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:59912
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S1161283AbWASTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:05:18 -0500
Date: Thu, 19 Jan 2006 11:05:17 -0800
From: Brad Boyer <flar@allandria.com>
To: Greg KH <greg@kroah.com>
Cc: linux-m68k@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
Message-ID: <20060119190517.GA4472@pants.nu>
References: <20060119180947.GA25001@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119180947.GA25001@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 10:09:47AM -0800, Greg KH wrote:
> Any ideas of how they made it into our tree?  And any chance of
> correcting them to be the correct license or removing them?

This is pretty old stuff. The files in arch/m68k/fpsp040/
implement all the extra 68881/68882 instructions that they
left out of the FPU that is builtin on the 68040. This is
the official Motorola provided implementation of them, and
they seem to be widely available.  I have no idea on the
license issues, however. One thing to note is that there is
a README file in that directory that appears to be part of
the original distribution of this code from Motorola with
some license info.

	Brad Boyer
	flar@allandria.com

