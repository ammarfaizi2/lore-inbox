Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUE1Qps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUE1Qps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUE1Qps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:45:48 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:38530 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263665AbUE1Qpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:45:47 -0400
Date: Fri, 28 May 2004 18:45:44 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Chris Mason <mason@suse.com>
Cc: David Madore <david.madore@ens.fr>, linux-kernel@vger.kernel.org
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by \000 bytes
Message-ID: <20040528164544.GF422@louise.pinerecords.com>
References: <20040528122854.GA23491@clipper.ens.fr> <1085748363.22636.3102.camel@watt.suse.com> <20040528162450.GE422@louise.pinerecords.com> <1085761753.22636.3329.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085761753.22636.3329.camel@watt.suse.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May-28 2004, Fri, 12:29 -0400
Chris Mason <mason@suse.com> wrote:

> On Fri, 2004-05-28 at 12:24, Tomas Szepe wrote:
> > On May-28 2004, Fri, 08:46 -0400
> > Chris Mason <mason@suse.com> wrote:
> > 
> > > > The bottom line: I've experienced file corruption, of the following
> > > > nature: consecutive regions (all, it seems, aligned on 256-byte
> > > > boundaries, and typically around 1kb or 2kb in length) of seemingly
> > > > random files are replaced by null bytes.  
> > > 
> > > The good news is that we tracked this one down recently.  2.6.7-rc1
> > > shouldn't do this anymore.
> > 
> > So did this only affect SMP machines?
> 
> No, if you slept in the right spot you could hit it on UP.

Uh oh.  Any idea about when the bug was introduced?

-- 
Tomas Szepe <szepe@pinerecords.com>
