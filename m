Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSEKDGy>; Fri, 10 May 2002 23:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316200AbSEKDGx>; Fri, 10 May 2002 23:06:53 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:15758 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316199AbSEKDGw>; Fri, 10 May 2002 23:06:52 -0400
Date: Fri, 10 May 2002 22:06:46 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget-locked [2/6] 
In-Reply-To: <3950.1021085326@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0205102204040.11642-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Keith Owens wrote:

> True, but if the iget change goes into 2.5 it will probably be
> backported to 2.4 later, 2.4 still has the restriction.

It's a two line change to Rules.make, so I suppose that can be backported
as well ;-) 

It's needed anyway IIRC, since s390 and ISDN both have fsm.o, and both do
export symbols.

--Kai

