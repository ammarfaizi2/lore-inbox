Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130847AbRARTpg>; Thu, 18 Jan 2001 14:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132643AbRARTp0>; Thu, 18 Jan 2001 14:45:26 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:26466 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130847AbRARTpN>; Thu, 18 Jan 2001 14:45:13 -0500
Date: Thu, 18 Jan 2001 21:52:02 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Padraig Brady <Padraig@AnteFacto.com>
cc: dmeyer@dmeyer.net, linux-kernel@vger.kernel.org
Subject: Re: Documenting stat(2)
In-Reply-To: <3A66D93C.8090500@AnteFacto.com>
Message-ID: <Pine.LNX.4.21.0101182150060.27730-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nope stat should return the details of the symlink
> whereas lstat should return the details of the symlink target.

It's the other way around according to the manpage, and my code also says
it's the other way around.

It's logical the way it is.. 

I use lstat to check if a config file is a symlink, and if it is, it
refuses to open it. 



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
