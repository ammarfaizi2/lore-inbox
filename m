Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTEILaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTEILaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:30:24 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:65494 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262459AbTEILaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:30:21 -0400
Date: Fri, 9 May 2003 12:42:48 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-ID: <20030509114248.GA19959@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@digeo.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030509021921.166f82fc.akpm@digeo.com> <200305091043.h49Ah7Z24822@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305091043.h49Ah7Z24822@magilla.sf.frob.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:43:07AM -0700, Roland McGrath wrote:
 > Here's an updated version of the patch.  Since the support for 386s without
 > WP support seems to be gone, I shaved an instruction here and there by not
 > passing the read/write flag to the helper function.  

should still be supported. this cset - 
http://linus.bkbits.net:8080/linux-2.5/cset@1.1078.1.24
rejigged how the WP test is done.

		Dave

