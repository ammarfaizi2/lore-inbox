Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317875AbSGVWoB>; Mon, 22 Jul 2002 18:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSGVWoB>; Mon, 22 Jul 2002 18:44:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56816 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317875AbSGVWoB>; Mon, 22 Jul 2002 18:44:01 -0400
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
From: Paul Larson <plars@austin.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       haveblue@us.ibm.com
In-Reply-To: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Jul 2002 17:34:32 -0500
Message-Id: <1027377273.5170.37.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 15:05, Rik van Riel wrote:
> Now that I think about it, could you try enabling RMAP_DEBUG
> in mm/rmap.c and try triggering this bug again ?
Done, output attached below.

On Mon, 2002-07-22 at 15:19, Dave Hansen wrote:
> I was hitting the same thing on a Netfinity 8500R/x370.  The problem 
> was an old compiler (egcs 2.91-something).  It was triggered by a few 
> different things, including kernprof and dcache_rcu.
Well, it was a redhat box.  Just to be certain, I made sure to use kgcc
and it still hung on boot, but kgcc is egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release).  If it would be helpful, I'll try compiling my
kernel on a debian box tomorrow and booting with that.

Thanks,
Paul Larson

