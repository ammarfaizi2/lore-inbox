Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263671AbUE1Q3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUE1Q3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbUE1Q3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:29:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:24811 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263671AbUE1Q3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:29:33 -0400
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by
	\000 bytes
From: Chris Mason <mason@suse.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: David Madore <david.madore@ens.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <20040528162450.GE422@louise.pinerecords.com>
References: <20040528122854.GA23491@clipper.ens.fr>
	 <1085748363.22636.3102.camel@watt.suse.com>
	 <20040528162450.GE422@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1085761753.22636.3329.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 12:29:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 12:24, Tomas Szepe wrote:
> On May-28 2004, Fri, 08:46 -0400
> Chris Mason <mason@suse.com> wrote:
> 
> > > The bottom line: I've experienced file corruption, of the following
> > > nature: consecutive regions (all, it seems, aligned on 256-byte
> > > boundaries, and typically around 1kb or 2kb in length) of seemingly
> > > random files are replaced by null bytes.  
> > 
> > The good news is that we tracked this one down recently.  2.6.7-rc1
> > shouldn't do this anymore.
> 
> So did this only affect SMP machines?

No, if you slept in the right spot you could hit it on UP.

-chris


