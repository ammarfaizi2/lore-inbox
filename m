Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbUBFUUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUBFUUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:20:17 -0500
Received: from letku14.adsl.netsonic.fi ([194.29.195.14]:2202 "EHLO
	tupa.firmament.fi") by vger.kernel.org with ESMTP id S265632AbUBFUUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:20:12 -0500
Date: Fri, 6 Feb 2004 22:20:06 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Limit hash table size
Message-ID: <20040206202006.GA19473@firmament.fi>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <20040205190904.0cacd513.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205190904.0cacd513.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: =?iso-8859-1?Q?Taneli_V=E4h=E4kangas?= <taneli@firmament.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc: list trimmed)

On Thu, Feb 05, 2004 at 07:09:04PM -0800, Andrew Morton wrote:
> A decent approach to the updatedb problem is an application hint which says
> "reclaim i/dcache harder".  Just turn it on during the updatedb run -
> crude, but it's a start.
> 
> But I've been telling poeple for a year that they should set
> /proc/sys/vm/swappiness to zero during the updatedb run and afaik nobody has
> bothered to try it...

Ok, I tried it. If anything, it made "interactive feel" slightly worse.
This is 2.6.2-rc3 on 2xPII-233, 128M RAM, 280M swap, Gnome and Mozilla.
If that does not apply, then forget about it. OTOH, I'd very much
appreciate if the system didn't act very sluggish during updatedb.

	Taneli

