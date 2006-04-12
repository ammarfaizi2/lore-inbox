Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWDLEqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWDLEqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 00:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWDLEqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 00:46:05 -0400
Received: from ozlabs.org ([203.10.76.45]:23722 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751356AbWDLEqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 00:46:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17468.34286.730652.585388@cargo.ozlabs.ibm.com>
Date: Wed, 12 Apr 2006 14:45:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ian Romanick <idr@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Special handling of sysfs device resource files?
In-Reply-To: <443C1ECA.1040308@us.ibm.com>
References: <443C1ECA.1040308@us.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Romanick writes:

> This seems to mostly work, but I am having one problem.  I map the
> region by opening the file with O_RDWR, then mmap with
> (PROT_READ|PROT_WRITE) and MAP_SHARED.  In all cases, the open and mmap
> succeed.  However, for I/O BARs, the resulting pointer from mmap is
> invalid.  Any access to it results in a segfault and GDB says it's "out
> of range".

On which architecture(s)?

Paul.
