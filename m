Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136808AbRECOAg>; Thu, 3 May 2001 10:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136814AbRECOA0>; Thu, 3 May 2001 10:00:26 -0400
Received: from [195.6.125.97] ([195.6.125.97]:60178 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S136808AbRECOAM>;
	Thu, 3 May 2001 10:00:12 -0400
Date: Thu, 3 May 2001 15:57:46 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: NEWBEE "reverse ioctl" or someting like
Message-Id: <20010503155746.2b87edd0.sebastien.person@sycomore.fr>
In-Reply-To: <Pine.LNX.4.10.10105030845110.4386-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <20010503142929.773147bf.sebastien.person@sycomore.fr>
	<Pine.LNX.4.10.10105030845110.4386-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 3 May 2001 08:46:05 -0400 (EDT)
Mark Hahn <hahn@coffee.psychology.mcmaster.ca> à écrit :

> > I think that use of pipe isn't preconised because I must fork process
> > to use pipe,
> 
> I guess you mean "because a user-level process would block on the pipe".
> and you don't want to block.  the alternative is to use a signal.

yes but with a signal I am able to share data beetween user space and kernel
space ? I must also use copy_to_user ?

