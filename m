Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135375AbRDLWwO>; Thu, 12 Apr 2001 18:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135376AbRDLWwD>; Thu, 12 Apr 2001 18:52:03 -0400
Received: from balu.sch.bme.hu ([152.66.224.40]:48536 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S135375AbRDLWvx>;
	Thu, 12 Apr 2001 18:51:53 -0400
Date: Fri, 13 Apr 2001 00:51:30 +0200
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [test-PATCH] Re: [QUESTION] 2.4.x nice level
Message-ID: <20010413005130.A4438@balu.sch.bme.hu>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104110726210.25737-100000@imladris.rielhome.conectiva> <Pine.LNX.4.21.0104111251040.25737-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0104111251040.25737-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Wed, Apr 11, 2001 at 12:53:16PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 12:53:16PM -0300, Rik van Riel wrote:
> On Wed, 11 Apr 2001, Rik van Riel wrote:
> 
> > OK, here it is. It's nothing like montavista's singing-dancing
> > scheduler patch that does all, just a really minimal change that
> > should stretch the nice levels to yield the following CPU usage:
> > 
> > Nice    0    5   10   15   19
> > %CPU  100   56   25    6    1
> 
>   PID USER     PRI  NI  SIZE SWAP  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>   980 riel      17   0   296    0  296   240 R    54.1  0.5  54:19 loop
>  1005 riel      16   5   296    0  296   240 R N  27.0  0.5   0:34 loop
>  1006 riel      17  10   296    0  296   240 R N  13.5  0.5   0:16 loop
>  1007 riel      18  15   296    0  296   240 R N   4.5  0.5   0:05 loop
>   987 riel      20  19   296    0  296   240 R N   0.4  0.5   0:25 loop

How does this scale to negative nice levels? Afaik it should, in some way.
(I don't mean that it's wrong in this state, i'm just asking).

regards,
Balazs.
