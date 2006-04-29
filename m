Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWD2GoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWD2GoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 02:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWD2GoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 02:44:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10176 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751465AbWD2GoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 02:44:19 -0400
Subject: Re: [openib-general] Re: possible bug in kmem_cache related code
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Or Gerlitz <or.gerlitz@gmail.com>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       open-iscsi@googlegroups.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <15ddcffd0604281224i4308b08fs93f9ebaf7e9a16b3@mail.gmail.com>
References: <Pine.LNX.4.44.0604271138370.16357-101000@zuben>
	 <84144f020604270419s10696877he2ec27ae6d52e486@mail.gmail.com>
	 <Pine.LNX.4.64.0604271510240.27370@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0604281108110.12202@sbz-30.cs.Helsinki.FI>
	 <15ddcffd0604281224i4308b08fs93f9ebaf7e9a16b3@mail.gmail.com>
Date: Sat, 29 Apr 2006 09:44:15 +0300
Message-Id: <1146293055.11279.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 21:24 +0200, Or Gerlitz wrote:
> Yes, i can reproduce this at will, no local modifications, my system
> is amd dual x86_64, i have attached my .config to the first email of
> this thread, and also mentioned that some CONFIG_DEBUG_ options are
> set, including one related to slab debugging.
> 
> Also, by "User mode Linux" you mean linux kernel that runs as a user
> process on your system?

Yeah, arch/um/. Unfortunately I don't have a SMP box, so I probably
can't reproduce this. You could try git bisect to isolate the offending
changeset.

				Pekka

