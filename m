Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUCUSzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUCUSzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:55:46 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:2564 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263700AbUCUSzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:55:42 -0500
Date: Sun, 21 Mar 2004 18:55:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] fix tiocgdev 32/64bit emul
Message-ID: <20040321185538.A10504@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	viro@parcelfarce.linux.theplanet.co.uk
References: <405DC698.4040802@pobox.com> <20040321165752.A9028@infradead.org> <405DE3EF.8090508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <405DE3EF.8090508@gmx.net>; from c-d.hailfinger.kernel.2004@gmx.net on Sun, Mar 21, 2004 at 07:50:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 07:50:23PM +0100, Carl-Daniel Hailfinger wrote:
> > Isn't that SuSE's strange ioctl hack that has been rejected for mainline
> > multiple times?  why does x86_64 have an emulation for it if the ioctl
> > isn't implemented anyway?
> 
> Since this pops up from time to time, please let me explain what TIOCGDEV
> does (if you know already, feel free to scoll to the end) and ask for
> alternative solutions.

Oh, I know what it does.  Have you ever looked at Al's rawconsole patch
that he coded up exactly in response to that hack?

ftp://ftp.linux.org.uk/pub/people/viro/ftp://ftp.linux.org.uk/pub/people/viro/X0-rawconsole-B5

