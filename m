Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWJVR4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWJVR4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWJVR4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:56:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26757 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751399AbWJVR4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:56:23 -0400
Date: Sun, 22 Oct 2006 18:56:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Message-ID: <20061022175609.GA28152@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Avi Kivity <avi@qumranet.com>, Arnd Bergmann <arnd@arndb.de>,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Anthony Liguori <aliguori@us.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de> <453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de> <453BA3E9.4050907@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453BA3E9.4050907@qumranet.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 07:01:29PM +0200, Avi Kivity wrote:
> >What is the point of 32 bit hosts anyway? Isn't this only available
> >on x86_64 type CPUs in the first place?
> >  
> 
> No, 32-bit hosts are fully supported (except a 32-bit host can't run a 
> 32-bit guest).

Again, what's the point?  All cpus shipped by Intel and AMD that have
hardware virtualization extensions also support the 64bit mode.  Given
that I don't see any point for supporting a 32bit host.

