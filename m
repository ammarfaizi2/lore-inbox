Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTFLG77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbTFLG77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:59:59 -0400
Received: from dp.samba.org ([66.70.73.150]:52461 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264797AbTFLG7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:59:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.10078.284006.569894@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jun 2003 17:10:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: Miles Lane <miles.lane@attbi.com>, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Looks like your PCI patch broke the PPC build (and others)?
In-Reply-To: <20030611202811.GA26387@kroah.com>
References: <3EE77FD6.9020502@attbi.com>
	<20030611202811.GA26387@kroah.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> Not my patch, Matthew's :)
> 
> I think the PPC developers have a fix for this.

Just #include <asm/pci-bridge.h> at the top of include/asm-ppc/pci.h.
I'll push that change to Linus.

Paul.
