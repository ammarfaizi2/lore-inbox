Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSKHPEb>; Fri, 8 Nov 2002 10:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSKHPEb>; Fri, 8 Nov 2002 10:04:31 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55707 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262128AbSKHPEb>; Fri, 8 Nov 2002 10:04:31 -0500
Subject: Re: NMI handling rework
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Corey Minyard <cminyard@mvista.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
In-Reply-To: <3DCA99F4.4090703@mvista.com>
References: <Pine.LNX.4.44.0211070103540.27141-100000@montezuma.mastecende.com> 
	<3DCA99F4.4090703@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 15:34:28 +0000
Message-Id: <1036769668.16651.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 16:51, Corey Minyard wrote:
> NMIs cannot be masked, they are by definition non-maskable :-).  You can 
> get an NMI while executing an NMI.

The intel docs certainly imply NMI is never interrupted by an NMI, so
you have one per CPU to worry about


