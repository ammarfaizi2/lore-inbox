Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTJHQj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 12:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTJHQj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 12:39:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6675 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261151AbTJHQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 12:39:26 -0400
Date: Wed, 8 Oct 2003 09:36:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Jones <davej@redhat.com>
cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Poll-based IDE driver
In-Reply-To: <20031008115051.GD705@redhat.com>
Message-ID: <Pine.LNX.4.10.10310080935350.7858-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does not matter, priority is to get content to platter and the hell with
everything else.  The reset button is your friend.

Andre Hedrick
LAD Storage Consulting Group

On Wed, 8 Oct 2003, Dave Jones wrote:

> On Wed, Oct 08, 2003 at 03:13:57PM +0530, Srivatsa Vaddagiri wrote:
> 
>  > /* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
>  > /* ToDo : replace this routine based on loops_per_jiffy?? */
>  > static inline void dump_udelay(unsigned int num_usec)
>  > {
>  > 	volatile unsigned int i;
>  > 	for (i = 0; i < 10000 * num_usec; i++);
>  > }
> 
> Why not just use udelay() ?  The above code cannot possibly do
> the right thing on all processors.
> 
> 		Dave
> 
> -- 
>  Dave Jones     http://www.codemonkey.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

