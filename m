Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269882AbUJHBSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269882AbUJHBSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUJGWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:55:28 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:10763 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269875AbUJGWeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:34:36 -0400
Date: Fri, 8 Oct 2004 00:34:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mmap specification - was: ... select specification
Message-ID: <20041007223434.GB7047@pclin040.win.tue.nl>
References: <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain> <001f01c4ac8b$35849710$161b14ac@boromir> <1097160628.31614.68.camel@localhost.localdomain> <20041007215834.GA7047@pclin040.win.tue.nl> <20041007221745.GA16597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007221745.GA16597@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 03:17:45PM -0700, Chris Wedgwood wrote:
> On Thu, Oct 07, 2004 at 11:58:34PM +0200, Andries Brouwer wrote:
> 
> > [I read this as follows: If you mmap a file with MAP_SHARED and
> > modify the memory at an address so far beyond EOF that it is not in
> > a page containing stuff from the file, then you get a SIGBUS. --
> > Linux does this.  Also, that if you modify the memory at an address
> > beyond EOF, then the file is not modified. -- Again Linux does
> > this.]
> 
> consider mmaping a 1-byte file ... you can modify bytes 0..4095.
> bytes 1..4095 shouldn't be recorded to disk ideally
> 
> at one point one fs did actually store this data and it caused cpp
> problems (it would expect to see zeroes and where it didn't it got
> upset)

Is this an answer? Or an anecdote?

[You seem to say anecdotically that at one point in time Linux mmap
was not POSIX compliant, and problems arose.
Alan on the other hand seems to say that POSIX comes with
ridiculous requirements.]

Andries
