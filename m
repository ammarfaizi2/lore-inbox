Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265064AbSJaAxF>; Wed, 30 Oct 2002 19:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSJaAxF>; Wed, 30 Oct 2002 19:53:05 -0500
Received: from zok.SGI.COM ([204.94.215.101]:2978 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S265064AbSJaAwn>;
	Wed, 30 Oct 2002 19:52:43 -0500
Date: Wed, 30 Oct 2002 16:59:06 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pcibus_to_node() addition to topology infrastructure
Message-ID: <20021031005906.GA1365@sgi.com>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DC06E75.6010003@us.ibm.com> <20021031000326.GA3049@sgi.com> <3DC0782D.20401@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC0782D.20401@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 04:24:13PM -0800, Matthew Dobson wrote:
> Ah, yes...  The p-bricks, i-bricks, etc. right?

Yup.

> Yes, I suppose a round-robin return for the SGI version of the macro 
> would work...  Certainly not ideal, but it would work.  The problem is 

Can you think of any better way to do it?  Perhaps make pcibus_to_node
return a list of nodes?

Thanks,
Jesse
