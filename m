Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTJANOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJANOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:14:32 -0400
Received: from aeschi.ch.eu.org ([157.161.173.20]:31450 "EHLO aeschi.ch.eu.org")
	by vger.kernel.org with ESMTP id S261384AbTJANOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:14:31 -0400
Date: Wed, 1 Oct 2003 15:14:11 +0200
From: Al Smith <Al.Smith@aeschi.ch.eu.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: include/linux/efs_fs.h declares a symbol
In-Reply-To: <20031001121643.GD31698@wohnheim.fh-wedel.de>
Message-ID: <Pine.SGI.4.58.0310011500530.21659@reclus.noc.genedata.com>
References: <20031001121643.GD31698@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Filter-Version: 1.14 (aeschi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Al, your version string cprt[] should better be in one of the .c files
> and the declaration in the header be extern.  No need to keep six
> seperate copies of that string in the kernel binary.

Sure, absolutely.

> Al Viro: There is no maintainer for efs in the kernel MAINTAINERS
> file.  Is this filesystem orphaned?

My answer would be yes and no. Yes, I'd like to keep it up to date with
the kernel in general, but in terms of actual development it's been in a
stable state for a couple of years now, and I have no current plans to add
further features.
