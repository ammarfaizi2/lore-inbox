Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbSIPOmL>; Mon, 16 Sep 2002 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSIPOmL>; Mon, 16 Sep 2002 10:42:11 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:5104 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262242AbSIPOmK>; Mon, 16 Sep 2002 10:42:10 -0400
Subject: Re: Oops in sched.c on PPro SMP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, mingo@redhat.com
In-Reply-To: <174178B9-C980-11D6-8873-00039387C942@mac.com>
References: <174178B9-C980-11D6-8873-00039387C942@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Sep 2002 15:49:27 +0100
Message-Id: <1032187767.1191.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 15:25, Peter Waechtler wrote:
> I suffered from lockups on PPro SMP as I switched from 2.4.18-SuSE
> to 2.4.19 and 2.4.20-pre7

What compiler did you build it with ? I've seen oopses like this from
gcc 3.0.x that went away with gcc 3.2, 2.95 or 2.96 

Also does turning off the nmi watchdog junk make the box stable ?

