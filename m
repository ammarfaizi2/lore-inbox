Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132730AbRDNDBZ>; Fri, 13 Apr 2001 23:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132732AbRDNDBF>; Fri, 13 Apr 2001 23:01:05 -0400
Received: from unthought.net ([212.97.129.24]:20357 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S132730AbRDNDBC>;
	Fri, 13 Apr 2001 23:01:02 -0400
Date: Sat, 14 Apr 2001 05:01:01 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Joe <joeja@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in float on Pentium
Message-ID: <20010414050101.G13740@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Joe <joeja@mindspring.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3AD78A6C.F0F3CF5A@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3AD78A6C.F0F3CF5A@mindspring.com>; from joeja@mindspring.com on Fri, Apr 13, 2001 at 07:23:24PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 07:23:24PM -0400, Joe wrote:
> Not sure but I think I found a NEW bug.
> 
> I know that there have been some issues with pentiums and floating point
> arrithmatic, but this takes the cake...
> 
> Linux Lserver.org 2.2.18 #43 SMP Fri Mar 9 14:19:41 EST 2001 i586
> unknown
> 
...
> 
> 
> I am getting the following as output
> 
> joeja@Lserver$ ./testf
> 5483.990000
> 5483.990234
> 
> 
> what is with the .990234??  it should be .990000
> 
> any ideas on this??
> 

Your second number is a 32-bit float - which has roughly 7 digits of
precision.   Just like your program output clearly shows.

(I do however fail to see the relevance of this to linux-kernel)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
