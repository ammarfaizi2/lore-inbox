Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSIZPAY>; Thu, 26 Sep 2002 11:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSIZPAY>; Thu, 26 Sep 2002 11:00:24 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:17657
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261347AbSIZPAY>; Thu, 26 Sep 2002 11:00:24 -0400
Subject: Re: [PATCH] fix ide-iops for big endian archs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20020925123223.16082@192.168.4.1>
References: <20020925123223.16082@192.168.4.1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 16:09:26 +0100
Message-Id: <1033052967.1348.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-25 at 13:32, Benjamin Herrenschmidt wrote:
> I enclosed the patch as an attachement too in case the mailer screws
> it up...

Please do one thing. For the stuff that needs weird powerpcisms put all
the seperate stuff in one block with its own copy of the static inlines
so we dont have in ifdef in half the functions in the file

