Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272387AbRIOQSi>; Sat, 15 Sep 2001 12:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272393AbRIOQS3>; Sat, 15 Sep 2001 12:18:29 -0400
Received: from smtp1.chicago.il.ameritech.net ([206.141.192.26]:5861 "EHLO
	smtp.ameritech.net") by vger.kernel.org with ESMTP
	id <S272387AbRIOQSP>; Sat, 15 Sep 2001 12:18:15 -0400
Date: Sat, 15 Sep 2001 12:21:19 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: linux-kernel@vger.kernel.org
Subject: Re: repeated nfs mounts..
In-Reply-To: <20010915123246.F7988@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.20.0109151220290.11838-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Sep 2001, Erik Mouw wrote:

> On Fri, Sep 14, 2001 at 07:18:36PM -0400, volodya@mindspring.com wrote:
> > Weird thing: I can repeatedly mount nfs filesystem over the same mount
> > point.. Anyone has an explanation ? I am running 2.4.9.
> 
> I think http://www.tux.org/lkml/#s14-6 answers your question.

But for a mount to succeed aren't we supposed to do this over an empty
directory ? So we should not be able to mount the same filesystem twice in
the same place (provided it has some files in it).

                                     Vladimir Dergachev

> 
> 
> Erik
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> 

