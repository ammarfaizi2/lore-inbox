Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUL2VCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUL2VCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUL2VCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:02:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29348 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261418AbUL2VA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:00:59 -0500
Subject: Re: running Linus kernel on FC3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412290853540.2899@skynet>
References: <Pine.LNX.4.58.0412290853540.2899@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104331982.30494.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Dec 2004 19:57:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-29 at 08:57, Dave Airlie wrote:
> I'm trying to run a linus bk tree on my FC3 system, but I get a lot of
> Selinux warnings with minilogd,
> 
> Are there some selinux patches that haven't made their way into Linus's
> tree but are in the FC kernel?

As of 2.6.10 none I can think of. 2.6.9 lacked SELinux security
attributes on tmpfs which was a problem if you ran SELinux seriously.
Needless to say 2.6.9-ac and 2.6.10-ac kernels are built and tested on
Fedora Core 2 and 3 along with 2.6.10 base and all worked fine for me.

