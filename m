Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUJWL2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUJWL2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJWL2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 07:28:41 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:39435 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267341AbUJWL2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 07:28:39 -0400
Date: Sat, 23 Oct 2004 12:28:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "C.Y.M" <syphir@syphir.sytes.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unknown symbol kill_proc_info in 2.6.10-rc1
Message-ID: <20041023112838.GA30910@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"C.Y.M" <syphir@syphir.sytes.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <417A2292.9090008@syphir.sytes.net> <20041023095714.GD30137@infradead.org> <417A2CBF.9060805@syphir.sytes.net> <20041023102203.GB30449@infradead.org> <417A3DD6.1030902@syphir.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417A3DD6.1030902@syphir.sytes.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 04:17:42AM -0700, C.Y.M wrote:
> >>Is there an alternative?
> >
> >
> >Maybe you could explain what you're actually trying to do at a higher
> >level first.
> >
> I have been using the lufs module in combination with autofs to be able 
> to automount ftp sites on the fly.  But, if lufs is broken due to the 
> lack of the "kill_proc_info" symbol being available, perhaps I will just 
> remove lufs and find another way (or wait until there is some kind of 
> patch for lufs).

Well, that's _too_ highlevel :)  The question is what lufs is trying to
archive by using the module.

