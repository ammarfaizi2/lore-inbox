Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTEOAj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTEOAj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:39:27 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:51727 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263279AbTEOAjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:39:24 -0400
Date: Thu, 15 May 2003 10:51:57 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andrew Morton <akpm@digeo.com>
cc: Ken Ashcraft <kash@stanford.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] Passing wrong size to memcpy/memset
In-Reply-To: <20030514173351.32c3a4c8.akpm@digeo.com>
Message-ID: <Mutt.LNX.4.44.0305151050220.11738-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Andrew Morton wrote:

> Ken Ashcraft <kash@stanford.edu> wrote:
> >
> > I'm with the Stanford Metacompilation research group and I wrote a checker
> > that looks for places where people use 'sizeof(ptr)' instead of
> > 'sizeof(*ptr)' as the length argument to memcpy/memset. 
> 
> Well they all look like genuine bugs.  It could be that some code is just
> performing overly-paranoid memsets.
> 
> I shall submit the below lot unless squeaked at.

No squeaks from me.

Ken, would you please try and Cc: maintainers for future reports?


- James
-- 
James Morris
<jmorris@intercode.com.au>

