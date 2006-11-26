Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967333AbWKZISs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967333AbWKZISs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 03:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967335AbWKZISr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 03:18:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56035 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S967333AbWKZISq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 03:18:46 -0500
Subject: Re: Overriding X on panic
From: Arjan van de Ven <arjan@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Casey Dahlin <cjdahlin@ncsu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20061125161043.18f1b68d@localhost.localdomain>
References: <1164434093.10503.2.camel@localhost.localdomain>
	 <1164443561.3147.54.camel@laptopd505.fenrus.org>
	 <20061125161043.18f1b68d@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 26 Nov 2006 09:18:41 +0100
Message-Id: <1164529121.3147.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-25 at 16:10 +0000, Alan wrote:
> > modesettings to use can still be in userspace, the execution of the
> > series of IO's would be in the kernel, and the kernel would store
> > bundles of settings, including a "rescue" one, but also for
> > suspend/resume...
> 
> The mode switch sequences for modern cards are a bit more hairy than
> lists of I/O poking unfortunately. 

for the Intel hw Keith doesn't seem to think it's all that much of a
problem though...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

