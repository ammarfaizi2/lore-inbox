Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVGZWI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVGZWI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVGZWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:08:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262167AbVGZWIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:08:22 -0400
Date: Tue, 26 Jul 2005 15:10:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726151003.6aa3aecb.akpm@osdl.org>
In-Reply-To: <1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	<20050726111110.6b9db241.akpm@osdl.org>
	<1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	<20050726114824.136d3dad.akpm@osdl.org>
	<20050726121250.0ba7d744.akpm@osdl.org>
	<1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com>
	<20050726142410.4ff2e56a.akpm@osdl.org>
	<1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Tue, 2005-07-26 at 14:24 -0700, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > ext2 is incredibly better. Machine is very responsive. 
> > > 
> > 
> > OK.  Please, always monitor and send /proc/meminfo.  I assume that the
> > dirty-memory clamping is working OK with ext2 and that perhaps it'll work
> > OK with ext3/data=writeback.
> 
> Nope. Dirty is still very high..

That's a relief in a way.  Can you please try decreasing the number of
filesystems now?

