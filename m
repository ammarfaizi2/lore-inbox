Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVCJJPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVCJJPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVCJJO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:14:56 -0500
Received: from colin2.muc.de ([193.149.48.15]:32275 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262485AbVCJJMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:12:44 -0500
Date: 10 Mar 2005 10:12:43 +0100
Date: Thu, 10 Mar 2005 10:12:43 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: greearb@candelatech.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
Message-ID: <20050310091243.GA8632@muc.de>
References: <422C1EC0.8050106@yahoo.com.au> <422D468C.7060900@candelatech.com> <422DD5A3.7060202@rapidforum.com> <422F8A8A.8010606@candelatech.com> <422F8C58.4000809@rapidforum.com> <422F9259.2010003@candelatech.com> <422F93CE.3060403@rapidforum.com> <20050309211730.24b4fc93.akpm@osdl.org> <m1is3zvprz.fsf@muc.de> <20050310010955.000ea843.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310010955.000ea843.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 01:09:55AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > In general to solve it one has to increase /proc/sys/vm/freepages
> >  a lot.
> 
> /proc/sys/vm/min_free_kbytes

Oh yes, I still have the old 2.2 name in my finger tips

(never understood why these things need to be always renamed; I guess
keeping the old name would have made it too easy on administrators) 

-Andi
