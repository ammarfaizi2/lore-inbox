Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319606AbSIMLk7>; Fri, 13 Sep 2002 07:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319607AbSIMLk7>; Fri, 13 Sep 2002 07:40:59 -0400
Received: from [212.18.235.100] ([212.18.235.100]:12962 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S319606AbSIMLk6>; Fri, 13 Sep 2002 07:40:58 -0400
From: kernel@street-vision.com
Message-Id: <200209131144.g8DBifW10216@tench.street-vision.com>
Subject: Re: AMD 760MPX DMA lockup (partly solved)
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Fri, 13 Sep 2002 11:44:40 +0000 (GMT)
Cc: kas@informatics.muni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <200209130702.g8D72sp09062@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Sep 13, 2002 09:58:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On 12 September 2002 17:14, Jan Kasprzak wrote:
> > : This is 2.4.20-pre1, dual AMD 2000MP, only difference is it is the Tyan
> > : version of the MPX, not the MSI.
> > :
> > : Justin
> >
> >         Justin, thanks for this! I've tried 2.4.20-pre1 with your
> > .config (and then with my .config), and it works!
> >
> >         Further investigation showed that the problem first appeared
> > somewhere between 2.4.20-pre2 (works for me) and 2.4.20-pre5 (has the
> > lock-up problem I've described). I was not able to test -pre3 and -pre4,
> > because these kernel died on me during boot after the
> > "Initializing RT netlink socket" message.
> 
> It would be interesting to test 2.4.20-pre5 on Justin's box
> (if he can risk fs damage)

ok, tried it on 2.4.20-pre5, and it is fine. 

I would send your board back...

Justin
