Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271659AbTGRAvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271662AbTGRAvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:51:09 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:24844 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271659AbTGRAvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:51:07 -0400
Date: Fri, 18 Jul 2003 03:05:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
       miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030718030558.B2612@pclin040.win.tue.nl>
References: <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl> <20030717131955.D2302@pclin040.win.tue.nl> <20030717145507.3ce5042c.akpm@osdl.org> <20030718002451.A2569@pclin040.win.tue.nl> <20030717224307.GF19891@ca-server1.us.oracle.com> <20030718011115.A2600@pclin040.win.tue.nl> <20030718000444.GG19891@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030718000444.GG19891@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Thu, Jul 17, 2003 at 05:04:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 05:04:45PM -0700, Joel Becker wrote:

> 	Yes, but there is a nice simplicity in saying filesystems that
> support 64bit device numbers get the expanded space, and filesystems
> that cannot are limited to 16bits.  Most modern systems would have an
> updated set of filesystems.  All pre-existing filesystems have only
> 16bit device numbers.  All new mknod64() calls will only work on
> filesystems that can store 64bits.

You are an optimist.
My transition is much slower - I am a slow kind of person.

There is no flag day. The kernel must be updated, glibc must be
updated, user space software must be updated. A long process
that will take years. Indeed, so far we have not succeeded in
updating the kernel, and eight years went by.

Filesystems? Last I looked reiserfs handled 32 bits.

Really, we need the three stages - if the middle 32-bit stage
is absent too much software breaks. We must go forward slowly.

Andries

