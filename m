Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSIOPIJ>; Sun, 15 Sep 2002 11:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSIOPIJ>; Sun, 15 Sep 2002 11:08:09 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:507 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318069AbSIOPII>; Sun, 15 Sep 2002 11:08:08 -0400
Subject: Re: [2.5] DAC960
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E17qQum-0001qO-00@starship>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020910062030.GL8719@suse.de> 
	<E17qQum-0001qO-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 15 Sep 2002 16:14:50 +0100
Message-Id: <1032102890.25716.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-15 at 05:21, Daniel Phillips wrote:
> A somewhat curt reply, it could be seen as a brush-off.  I believe the
> whole story goes something like this: the scsi system is a festering
> sore on the whole and eventually needs to be rationalized.  But until
> that happens, we should basically just keep nursing along the various
> drivers that should be using a generic interface, until there really
> is a generic interface around worth putting in the effort to port to.

DAC960 doesn't present a scsi interface to the higher levels. Its
abstraction truely is block based, like i2o_block, like aacraid, like
many other cards.

