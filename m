Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSIBUpe>; Mon, 2 Sep 2002 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318470AbSIBUpe>; Mon, 2 Sep 2002 16:45:34 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:36091
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318460AbSIBUpd>; Mon, 2 Sep 2002 16:45:33 -0400
Subject: Re: Poweroff error from 2.4.20-pre5-ac1 w/ Asus A7M266-D
	motherboard AND question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209021618.15767.spstarr@sh0n.net>
References: <200209021618.15767.spstarr@sh0n.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 02 Sep 2002 21:51:26 +0100
Message-Id: <1030999886.3582.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-02 at 21:18, Shawn Starr wrote:
> First the question:
> 
> Why does Linux detect my AMD chipset as ONLY the MP and not the MPX? I thought the A7M266-D had the MPX? 

The northbridge is the same so that shouldnt matter. The hdc is probably
a bug in the new ide code. It may be fixed by pre3 (coming up soon)

