Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSBCWTK>; Sun, 3 Feb 2002 17:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSBCWTC>; Sun, 3 Feb 2002 17:19:02 -0500
Received: from elin.scali.no ([62.70.89.10]:25871 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S287817AbSBCWSm>;
	Sun, 3 Feb 2002 17:18:42 -0500
Message-ID: <3C5DB730.B54B17B4@scali.com>
Date: Sun, 03 Feb 2002 23:18:24 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <Pine.LNX.4.33.0202031632580.11943-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Sun, 3 Feb 2002, Steffen Persvold wrote:
> 
> > Can generic_make_request() be called from interrupt level (or tasklet)
> > ?
> 
> no.
> 

OK, so are there any other way I can submit a block request from a tasklet (that is interrupt
context, right ?) ?

Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
