Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUG1NLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUG1NLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 09:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUG1NLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 09:11:49 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:52675 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266910AbUG1NLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 09:11:48 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: jmoyer@redhat.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: allow recursive die() on i386 
In-reply-to: Your message of "Wed, 28 Jul 2004 08:35:39 -0400."
             <16647.40347.365356.770724@segfault.boston.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Jul 2004 23:11:37 +1000
Message-ID: <9424.1091020297@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 08:35:39 -0400, 
Jeff Moyer <jmoyer@redhat.com> wrote:
>This patch allows for a recursive die() on i386.  This closely resembles
>what is done on x86_64, fwiw.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm1/broken-out/make-i386-die-more-resilient-against-recursive-errors.patch

does this and more, it also guards against too many recursive calls to
die.  The patch is already in Andrew's tree.

