Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161392AbWAMQiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161392AbWAMQiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWAMQiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:38:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17589 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161392AbWAMQiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:38:09 -0500
Date: Fri, 13 Jan 2006 16:37:53 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-ID: <20060113163753.GJ27946@ftp.linux.org.uk>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru> <20060107154842.5832af75.akpm@osdl.org> <20060110182422.d26c5d8b.pj@sgi.com> <20060113141154.GL29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113141154.GL29663@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 03:11:54PM +0100, Adrian Bunk wrote:
> It can always happen that one out of fifty patches breaks compilation on 
> some architectures, and I'm for sure not the one with the worst 
> errors/patches ratio.
> 
> -mm is an experimental kernel and although breakages are unfortunate, 
> they do happen.
> 
> I'm already compiling every single patch with both a non-modular and a 
> completely modular .config for i386. This is the amout of testing I can 
> afford. If this isn't considered enough I have to stop submtting 
> patches.

This is not considered enough.  If you can't be arsed to set up cross-compilers
on your box, please *stop* shitting in headers that might affect something
other than i386.  It's not like doing a cross-toolchain was something hard...
