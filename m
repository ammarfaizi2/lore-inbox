Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268171AbTBNDlY>; Thu, 13 Feb 2003 22:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268173AbTBNDlY>; Thu, 13 Feb 2003 22:41:24 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:65471 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S268171AbTBNDlX>; Thu, 13 Feb 2003 22:41:23 -0500
Subject: Re: Synchronous signal delivery..
From: Keith Adamson <keith.adamson@attbi.com>
To: Keith Adamson <keith.adamson@attbi.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045192268.14703.20.camel@x1-6-00-d0-70-00-74-d1>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> 
	<20030214024046.GA18214@bjl1.jlokier.co.uk> 
	<1045192268.14703.20.camel@x1-6-00-d0-70-00-74-d1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 22:54:22 -0500
Message-Id: <1045194862.14683.32.camel@x1-6-00-d0-70-00-74-d1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 22:11, Keith Adamson wrote:
> 
> How about also including a connect()/bind() interface so that 
> you can sort of have a "sockets for signals" type interface.  
> This seems like a nice type of interface for synchronization.
> And maybe use send()/recv() instead of read()/write().  Or am 
> I on crack:)
> 

I guess what I'm trying to say is that if you want to generalize 
a synchronous signal delivery interface I think the networking 
interface is a better paradigm than the filesystem interface.



