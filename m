Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318666AbSG0Ash>; Fri, 26 Jul 2002 20:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318667AbSG0Ash>; Fri, 26 Jul 2002 20:48:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41980 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318666AbSG0Ash>; Fri, 26 Jul 2002 20:48:37 -0400
Subject: Re: Handling NMI in a kernel module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Robertson <alanr@unix.sh>
Cc: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>,
       "Linux-Ha (E-mail)" <linux-ha@muc.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <3D41C544.9090702@unix.sh>
References: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com> 
	<3D41C544.9090702@unix.sh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jul 2002 03:05:57 +0100
Message-Id: <1027735557.15951.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been tracking other lists. The current state is very much that we
need the dual notifier. I now have some draft code that allows us to do
this even on hardware that doesn't support it, and where the read()
function gets told when an event is about to occur

