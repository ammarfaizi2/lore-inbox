Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUE1QzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUE1QzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUE1QzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:55:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:29839 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261668AbUE1QzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:55:20 -0400
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by
	\000 bytes
From: Chris Mason <mason@suse.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: David Madore <david.madore@ens.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <20040528164544.GF422@louise.pinerecords.com>
References: <20040528122854.GA23491@clipper.ens.fr>
	 <1085748363.22636.3102.camel@watt.suse.com>
	 <20040528162450.GE422@louise.pinerecords.com>
	 <1085761753.22636.3329.camel@watt.suse.com>
	 <20040528164544.GF422@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1085763331.22636.3334.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 12:55:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 12:45, Tomas Szepe wrote:

[ reiserfs data corruption bug ]

> > > So did this only affect SMP machines?
> > 
> > No, if you slept in the right spot you could hit it on UP.
> 
> Uh oh.  Any idea about when the bug was introduced?

2.6.6, with the reiserfs data=ordered patches.

-chris


