Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSILSLQ>; Thu, 12 Sep 2002 14:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSILSLQ>; Thu, 12 Sep 2002 14:11:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:43478 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316789AbSILSLP>;
	Thu, 12 Sep 2002 14:11:15 -0400
Subject: RE: Killing/balancing processes when overcommited
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Giuliano Pochini <pochini@shiny.it>,
       "Troy Reed" <tdreed@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF6229FEF.18E6AE99-ON88256C32.00641173@boulder.ibm.com>
From: "Jim Sibley" <jlsibley@us.ibm.com>
Date: Thu, 12 Sep 2002 11:14:03 -0700
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/12/2002 12:15:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Agreed, and I think its up to the installation to decide who that process
is.

Regards, Jim
Linux S/390-zSeries Support, SEEL, IBM Silicon Valley Labs
t/l 543-4021, 408-463-4021, jlsibley@us.ibm.com
*** Grace Happens ***



                                                                                                                  
                      Rik van Riel                                                                                
                      <riel@conectiva.c        To:       Giuliano Pochini <pochini@shiny.it>                      
                      om.br>                   cc:       Jim Sibley/San Jose/IBM@IBMUS, Troy Reed/Santa           
                                                Teresa/IBM@IBMUS, <linux-kernel@vger.kernel.org>                  
                      09/12/02 12:02 PM        Subject:  RE: Killing/balancing processes when overcommited        
                                                                                                                  
                                                                                                                  
                                                                                                                  



On Thu, 12 Sep 2002, Giuliano Pochini wrote:
> On 11-Sep-2002 Jim Sibley wrote:
> > I have run into a situation in a multi-user Linux environment that when
> > memory is exhausted, random things happen. [...] In a "well tuned"
system,
> > we are safe, but when the system accidentally (or deliberately) becomes
> > "detuned", oom_kill is entered and arbitrarily kills  a  process.
>
> It's not difficult to make the kerner choose the right processes
> to kill. It's impossible.

This assumes there is only 1 "good" process to kill.  In reality
there will often be a number of acceptable candidates, so we just
need to identify one of those ;)

Rik
--
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/                    http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org






