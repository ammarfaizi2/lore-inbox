Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUBPVKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265896AbUBPVKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:10:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21909 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265883AbUBPVKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:10:35 -0500
Date: Mon, 16 Feb 2004 21:10:33 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040216211033.GN8858@parcelfarce.linux.theplanet.co.uk>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <20040216201610.GC17015@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216201610.GC17015@schmorp.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 09:16:10PM +0100, Marc Lehmann wrote:
> The point is, however, that this is highly undesirable, and it would be
> nice to have a kernel that would (optionally) fully support a UTF-8
> environment in where applications can feed UTF-8 and _expect_ UTF-8 in
> return, which _is_ a security issue.
> 
> It's very desirable to have a kernel that actively supports this. IT is
> clearly not _required_, of course. But then again, process abstraction
> is also not required...

Mind taking the demagogy elsewhere?  Note that the same handwaving applies
to e.g. file contents.  Care to explain what makes read() and write()
different in that respect?
