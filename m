Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUAAOKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 09:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUAAOKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 09:10:34 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:62468 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263544AbUAAOKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 09:10:33 -0500
Date: Thu, 1 Jan 2004 15:10:27 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Neale Banks <neale@lowendale.com.au>, paul@clubi.ie,
       linux-kernel@vger.kernel.org
Subject: Re: chmod of active swap file blocks
Message-ID: <20040101151027.A2411@pclin040.win.tue.nl>
References: <Pine.LNX.4.56.0312291719160.16956@fogarty.jakma.org> <Pine.LNX.4.05.10401011905310.31562-100000@marina.lowendale.com.au> <20040101021241.31830e30.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040101021241.31830e30.akpm@osdl.org>; from akpm@osdl.org on Thu, Jan 01, 2004 at 02:12:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 02:12:41AM -0800, Andrew Morton wrote:
> Neale Banks <neale@lowendale.com.au> wrote:
> >
> > How much of the original problem goes away if swapon(8) were to refuse to
> >  activate a file/device which has ownership/mode which it doesn't like?
> 
> I think swapon(8) should at least warn when the swapfile has inappropriate
> permissions.  It's an obvious and outright security hole.

swapon had this warning for a while, but that generated lots of complaints.
Now this message is printed only when the -v (verbose) flag is given.

