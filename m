Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSG2Lkz>; Mon, 29 Jul 2002 07:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSG2Lky>; Mon, 29 Jul 2002 07:40:54 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32503 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315415AbSG2Lkx>; Mon, 29 Jul 2002 07:40:53 -0400
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D4521F5.3070306@evision.ag>
References: <200207290026.RAA00298@baldur.yggdrasil.com>
	<1027943789.842.25.camel@irongate.swansea.linux.org.uk> 
	<3D4521F5.3070306@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 13:59:51 +0100
Message-Id: <1027947591.842.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 12:07, Marcin Dalecki wrote:
> > Martin - is the host lock held when the tuning function is called ?
> 
> Unfortunately not. Not right now. But if you are fixing something
> beneath - please "pretend" it is, since it should :-).

Ok. In which case I will wait since that change will remove the cli/sti
stuff completely from almost every isa/eisa IDE controller
