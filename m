Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTKRPt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 10:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTKRPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 10:49:26 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:48310 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263679AbTKRPtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 10:49:25 -0500
Date: Tue, 18 Nov 2003 15:49:21 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031118154921.GA28942@mail.shareable.org>
References: <1068512710.722.161.camel@cube.suse.lists.linux.kernel> <20031111133859.GA11115@bitwizard.nl.suse.lists.linux.kernel> <20031111085323.M8854@devserv.devel.redhat.com.suse.lists.linux.kernel> <bp0p5m$lke$1@cesium.transmeta.com.suse.lists.linux.kernel> <20031113233915.GO1649@x30.random.suse.lists.linux.kernel> <3FB4238A.40605@zytor.com.suse.lists.linux.kernel> <20031114011009.GP1649@x30.random.suse.lists.linux.kernel> <3FB42CC4.9030009@zytor.com.suse.lists.linux.kernel> <p734qx7rmyf.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734qx7rmyf.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > s/EINTR/short count/, of course :)
> 
> That would be buggy because existing users of sendfile don't know
> about this and would silently only copy part of the file when a signal
> happens.

That doesn't make sense.  There aren't any existing users of sendfile
to copy files.

-- Jamie
