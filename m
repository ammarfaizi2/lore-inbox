Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318372AbSGYJkL>; Thu, 25 Jul 2002 05:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318388AbSGYJkL>; Thu, 25 Jul 2002 05:40:11 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23546 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318372AbSGYJkL>; Thu, 25 Jul 2002 05:40:11 -0400
Subject: Re: puzzling kernel hangs with 2.4.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Zawinski <jwz@jwz.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D3FC052.43740DB4@jwz.org>
References: <3D3FC052.43740DB4@jwz.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 11:57:15 +0100
Message-Id: <1027594635.9489.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any suggestions?

Start with getting the errata kernel, see if that helps. I don't think
it will make a difference but lets be sure. Also check the box with
memtest86. 2.4 does stress hardware way harder than 2.2, especially if
the box is an AMD Athlon

If that doesn't help do also file an entry in
	https://bugzilla.redhat.com/bugzilla

It may be a problem with the Red Hat patches not the base kernel so it
is useful for us to be able to track it too.

