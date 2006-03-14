Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWCNWZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWCNWZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWCNWZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:25:55 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:21727 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932528AbWCNWZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:25:54 -0500
Date: Tue, 14 Mar 2006 15:25:53 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, maule@sgi.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060314222553.GX1653@parisc-linux.org>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <20060314215922.GA12257@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314215922.GA12257@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 01:59:22PM -0800, Greg KH wrote:
> Ugh.  What is the file that is causing the problem?  What is "include2"
> in your directory path above?

you get include2 when you specify a different object directory:

$ ls obj
Makefile        arch    drivers  include2  kernel  net       sound
Module.symvers  block   fs       init      lib     scripts   usr
System.map      crypto  include  ipc       mm      security  vmlinux

