Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUE1QZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUE1QZC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 12:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbUE1QZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 12:25:02 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:31874 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263624AbUE1QY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 12:24:59 -0400
Date: Fri, 28 May 2004 18:24:50 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Chris Mason <mason@suse.com>
Cc: David Madore <david.madore@ens.fr>, linux-kernel@vger.kernel.org
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by \000 bytes
Message-ID: <20040528162450.GE422@louise.pinerecords.com>
References: <20040528122854.GA23491@clipper.ens.fr> <1085748363.22636.3102.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085748363.22636.3102.camel@watt.suse.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May-28 2004, Fri, 08:46 -0400
Chris Mason <mason@suse.com> wrote:

> > The bottom line: I've experienced file corruption, of the following
> > nature: consecutive regions (all, it seems, aligned on 256-byte
> > boundaries, and typically around 1kb or 2kb in length) of seemingly
> > random files are replaced by null bytes.  
> 
> The good news is that we tracked this one down recently.  2.6.7-rc1
> shouldn't do this anymore.

So did this only affect SMP machines?

-- 
Tomas Szepe <szepe@pinerecords.com>
