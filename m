Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbULXDei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbULXDei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 22:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbULXDei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 22:34:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:48791 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261362AbULXDeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 22:34:23 -0500
Date: Fri, 24 Dec 2004 14:33:47 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] XFS crash using Realtime Preemption patch
Message-ID: <20041224143346.B733309@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu> <20041221104042.GA31843@elte.hu> <20041222093242.B674830@wobbly.melbourne.sgi.com> <Pine.LNX.4.60-041.0412220246390.11361@unix49.andrew.cmu.edu> <20041223105858.C702917@wobbly.melbourne.sgi.com> <Pine.LNX.4.60-041.0412232224000.9915@unix49.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.60-041.0412232224000.9915@unix49.andrew.cmu.edu>; from nwf@andrew.cmu.edu on Thu, Dec 23, 2004 at 10:27:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 10:27:32PM -0500, Nathaniel W. Filardo wrote:
> If the BUG_ON didn't trigger, we shouldn't get a recognisable hex pattern 
> - we'll get a 1 or a 0 every time, yes?

Of course, you're right - sorry, my brains switched off.  I'll
take a look in the new year if you don't figure it out before
I get back. :)  The only other thought I had was perhaps the
writer field assignment is getting reordered around the atual
lock, may need some judicious use of memory barriers in there;
that needs some details analysis though.

cheers.

-- 
Nathan
