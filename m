Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSG0LWJ>; Sat, 27 Jul 2002 07:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318737AbSG0LWJ>; Sat, 27 Jul 2002 07:22:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:15101 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318735AbSG0LWI>; Sat, 27 Jul 2002 07:22:08 -0400
Subject: Re: Handling NMI in a kernel module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Robertson <alanr@unix.sh>
Cc: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>,
       "Linux-Ha (E-mail)" <linux-ha@muc.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <3D4213D4.6020705@unix.sh>
References: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>
	<3D41C544.9090702@unix.sh>
	<1027735557.15951.3.camel@irongate.swansea.linux.org.uk> 
	<3D4213D4.6020705@unix.sh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jul 2002 13:39:42 +0100
Message-Id: <1027773582.17404.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-27 at 04:30, Alan Robertson wrote:
> Alan Cox wrote:
> > I've been tracking other lists. The current state is very much that we
> > need the dual notifier. I now have some draft code that allows us to do
> > this even on hardware that doesn't support it, and where the read()
> > function gets told when an event is about to occur
> 
> I know what had been requested from the telco crowd was the ability to 
> register a function to get called (in the kernel) when an event was about to 
> occur.

They can already do that anyway. Its called add_timer() 8)

