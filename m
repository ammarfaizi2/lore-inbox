Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280680AbRKBNIB>; Fri, 2 Nov 2001 08:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280681AbRKBNHx>; Fri, 2 Nov 2001 08:07:53 -0500
Received: from mail11.speakeasy.net ([216.254.0.211]:24843 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S280680AbRKBNHi>; Fri, 2 Nov 2001 08:07:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: graphical swap comparison of aa and rik vm
Date: Fri, 2 Nov 2001 08:07:37 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0111020915390.2963-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0111020915390.2963-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102130748Z280680-17408+9378@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 November 2001 06:17, Rik van Riel wrote:
> On Thu, 1 Nov 2001, safemode wrote:
> > I think the answer of why AA's kernel beat rik's has nothing to do
> > with how much swap rik is using or how much swap is being swapped back
> > in.  It has to do with how rik decides what to swap.  Apparently the
> > algorithm used by rik to play with memory is taking seriously too much
> > cpu and it leaves little for the actual process to work.
>
> Note that this is likely to be a side effect of running
> completely out of swap, because that means many of the
> "obvious candidates" of what to swap out cannot be swapped
> out, meaning we have to scan more pages until we find
> something which already has swap backing.
>
> Before you draw conclusions like the one above, please test
> again with more swap.
>
> regards,
>
> Rik

I'll try it with  more swap later on today after work.  But realize, though,  
the fact that you need much more swap to do the same thing (compared to aa's) 
is not helping any adoption of the VM.  
