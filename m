Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVEKO2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVEKO2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEKO2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:28:37 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:59577 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261827AbVEKO2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:28:18 -0400
Date: Wed, 11 May 2005 10:27:45 -0400
To: Rudolf Usselmann <rudi@asics.ws>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel (64bit) 4GB memory support
Message-ID: <20050511142745.GQ2281@csclub.uwaterloo.ca>
References: <20041216074905.GA2417@c9x.org> <1103213359.31392.71.camel@cpu0> <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com> <1103646195.3652.196.camel@cpu0> <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com> <1103647158.3659.199.camel@cpu0> <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com> <1115654185.3296.658.camel@cpu10> <20050509200721.GE2297@csclub.uwaterloo.ca> <1115754522.4409.16.camel@cpu10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115754522.4409.16.camel@cpu10>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 02:48:42AM +0700, Rudolf Usselmann wrote:
> I do see the full 4G. With Fedora Core 2 32bit, I can use all
> 4G as well. All my problems started when I "upgraded" to x86_64 ...

In 32bit it probably uses the PSE36 extensions or something, which isn't
the same thing as flat 64bit memory access.  It could just be a matter
of needing a memory hole somewhere for PCI space or something.  I only
have 1G in my 64bit machine so I haven't got near these problems.

Len Sorensen
