Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWJRQJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWJRQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJRQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:09:28 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:3241 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161225AbWJRQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:09:28 -0400
Date: Wed, 18 Oct 2006 10:09:26 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Brian King <brking@us.ibm.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable pci device
Message-ID: <20061018160926.GS22289@parisc-linux.org>
References: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org> <1161187503.9363.75.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161187503.9363.75.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 05:05:02PM +0100, Alan Cox wrote:
> If the user specified O_NDELAY then -EWOULDBLOCK not wait

sysfs doesn't give us the struct file, so we can't tell.
