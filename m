Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSENATj>; Mon, 13 May 2002 20:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSENATi>; Mon, 13 May 2002 20:19:38 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:48046 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S293510AbSENATg>; Mon, 13 May 2002 20:19:36 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
From: Joel Becker <joel.becker@oracle.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
        zaitcev@redhat.com
In-Reply-To: <E177PSB-0006bH-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 13 May 2002 17:19:26 -0700
Message-Id: <1021335567.2455.9.camel@insight>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-13 at 16:42, Alan Cox wrote:
> > There are at least 2 that I thought might be good discussion topics;
> > 	Sockets Direct Protocol for InfiniBand
> > 	User Mode Access to the InfiniBand network
> 
> Surely these are the same topic ?

	Nope.  There are three issues here, really.  The second item, "User
Mode Access" is probably one or both of two things.  A "native" IBA
interface (aka Verbs).  These are the actual IBA work elements.  Things
like Subnet Managers need access to this.  The other is uDAPL (user
Direct Access Programming Library).  uDAPL (and kDAPL) are emerging
standards for high-speed messaging systems (VIA/IBA/Myrinet type
things).  uDAPL is likely the protocol most of userspace will want to
program to.

Joel 

-- 

 "I'm living so far beyond my income that we may almost be said
 to be living apart."
         - e e cummings

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
