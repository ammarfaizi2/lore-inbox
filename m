Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRECPTk>; Thu, 3 May 2001 11:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRECPTa>; Thu, 3 May 2001 11:19:30 -0400
Received: from home.paris.trader.com ([195.68.19.162]:60646 "EHLO
	jbueno.netclub") by vger.kernel.org with ESMTP id <S131307AbRECPTQ>;
	Thu, 3 May 2001 11:19:16 -0400
Message-ID: <3AF17704.FD37C133@trader.com>
Date: Thu, 03 May 2001 17:19:32 +0200
From: Joseph Bueno <joseph.bueno@trader.com>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
CC: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: NEWBEE "reverse ioctl" or someting like
In-Reply-To: <20010503142929.773147bf.sebastien.person@sycomore.fr>
		<Pine.LNX.4.10.10105030845110.4386-100000@coffee.psychology.mcmaster.ca> <20010503155746.2b87edd0.sebastien.person@sycomore.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sébastien person wrote:
> 
> Le Thu, 3 May 2001 08:46:05 -0400 (EDT)
> Mark Hahn <hahn@coffee.psychology.mcmaster.ca> à écrit :
> 
> > > I think that use of pipe isn't preconised because I must fork process
> > > to use pipe,
> >
> > I guess you mean "because a user-level process would block on the pipe".
> > and you don't want to block.  the alternative is to use a signal.
> 
> yes but with a signal I am able to share data beetween user space and kernel
> space ? I must also use copy_to_user ?

You will not get any data with the signal but your user-level application
can use an ioctl when it receives this signal and get the data.

--
Joseph Bueno
NetClub/Trader.com
