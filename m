Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTKKI6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTKKI6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:58:13 -0500
Received: from mail.enyo.de ([212.9.189.167]:23054 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264278AbTKKI6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:58:12 -0500
Date: Tue, 11 Nov 2003 09:58:06 +0100
To: Valdis.Kletnieks@vt.edu, Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111085806.GC11435@deneb.enyo.de>
References: <1068512710.722.161.camel@cube> <20031110205011.R10197@schatzie.adilger.int> <1068523406.4156.7.camel@localhost> <200311110414.hAB4EZA8007309@turing-police.cc.vt.edu> <20031110230055.S10197@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110230055.S10197@schatzie.adilger.int>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> > This is fast turning into a creeping horror of aggregation.  I defy anybody
> > to create an API to cover all the options mentioned so far and *not* have it
> > look like the process_clone horror we so roundly derided a few weeks ago.
> 
> 	int sys_copy(int fd_src, int fd_dst)

Doesn't work.  You have to set the security attributes while you open
fd_dst.
