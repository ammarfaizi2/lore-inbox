Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTKVTve (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 14:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTKVTve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 14:51:34 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:42424 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262738AbTKVTvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 14:51:33 -0500
Date: Sat, 22 Nov 2003 19:50:52 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Timothy Miller <miller@techsource.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       Justin Cormack <justin@street-vision.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031122195052.GA17077@mail.shareable.org>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby> <20031120172143.GA7390@deneb.enyo.de> <03112013081700.27566@tabby> <1069357453.26642.93.camel@lotte.street-vision.com> <3FBD27A0.50803@techsource.com> <20031120140739.I20568@schatzie.adilger.int> <3FBD328C.1070607@techsource.com> <20031122145031.GA189@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031122145031.GA189@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > It is, though.  If you run out of space copying a file, you know it when 
> > you're copying.  Applications don't usually expect to get out-of-space 
> > errors while overwriting something in the middle of a file.
> 
> Same can happen on compressed filesystem...

Or a filesystem with snapshots, e.g. using LVM.

-- Jamie
