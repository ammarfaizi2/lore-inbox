Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264273AbRFOJJV>; Fri, 15 Jun 2001 05:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264298AbRFOJJL>; Fri, 15 Jun 2001 05:09:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41224 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264279AbRFOJJC>; Fri, 15 Jun 2001 05:09:02 -0400
Message-ID: <3B29D048.4E19D545@idb.hist.no>
Date: Fri, 15 Jun 2001 11:07:20 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Ivan Schreter <is@zapwerk.com>, linux-kernel@vger.kernel.org
Subject: Re: Buffer management - interesting idea
In-Reply-To: <01060613422800.07218@linux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Schreter wrote:
> 
> Hello,
> 
> I'm working on some hi-speed DB projects under Linux and I was researching
> various buffer-replacement algorithms. I found 2Q buffer replacement policy at
> 
>         http://citeseer.nj.nec.com/63909.html
> 
> Maybe it would be interesting to use it instead of LRU for disk buffer
> replacement. Seems relatively easy to implement and costs are about the same as
> for LRU.

The "resistance to scanning" seemed interesting, maybe one-time
activities like a "find" run or big cat/dd will have less impact with
this.


Helge Hafting
