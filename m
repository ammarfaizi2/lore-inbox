Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbSLSWKY>; Thu, 19 Dec 2002 17:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267630AbSLSWJl>; Thu, 19 Dec 2002 17:09:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267227AbSLSWJe>;
	Thu, 19 Dec 2002 17:09:34 -0500
Date: Thu, 19 Dec 2002 15:49:05 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Sam Ravnborg <sam@ravnborg.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: drivers/base/fs/fs.h - needed?
In-Reply-To: <20021217200405.GA1191@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.33.0212191543000.1286-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Dec 2002, Sam Ravnborg wrote:

> In fs/partitions/check.c the following ugly include exists:
> #include <../drivers/base/fs/fs.h>	/* Eeeeewwwww */
> 
> It can be killed with no problem, the prototypes contained therein are
> not used by check.c.
> 
> Is this preparations for furter device model changes?
> If thats the case, the fs.h file, or at least the content, shall be placed
> in include/linux for general access.

It can safely be removed. 

Thanks

	-pat

