Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTDNOpQ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTDNOpQ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:45:16 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:15595 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263015AbTDNOpQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 10:45:16 -0400
Date: Mon, 14 Apr 2003 17:07:59 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Bryan Shumsky <bzs@via.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
Message-ID: <20030414150759.GA14552@wind.cocodriloo.com>
References: <002101c30239$fc0ae630$fe64a8c0@webserver> <8180000.1050330998@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8180000.1050330998@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 07:36:39AM -0700, Martin J. Bligh wrote:
> > Hi, everyone.  I'm running into a problem that I hope someone else has seen,
> > and maybe can help solve.  We're using the mmap system function for memory
> > mapped files, but our updates never get flushed until we munmap or msysnc.
> > Are we missing something?  Is there a tunable parameter in the kernel or
> > filing system that can be set to flag these updates as 'write required'?
> 
> This was discussed about a week ago on either linux-kernel or linux-mm.
> The short answer is "yes, that's deliberate", but an archive search would 
> probably be fruitful.
> 
> M.

Martin, something which was not mentioned last week (I've just checked).

It's OK if we never write to disk unless explicitely told, but will we writeback
when we munmap?

Greets, Antonio.
