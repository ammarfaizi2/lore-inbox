Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268079AbSIRRnH>; Wed, 18 Sep 2002 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268122AbSIRRnH>; Wed, 18 Sep 2002 13:43:07 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:43261
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268079AbSIRRnF>; Wed, 18 Sep 2002 13:43:05 -0400
Subject: Re: Info: NAPI performance at "low" loads
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca, akpm@digeo.com,
       manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1hegnky2h.fsf@frodo.biederman.org>
References: <3D87A59C.410FFE3E@digeo.com>
	<Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca>
	<20020917.180014.07882539.davem@redhat.com> 
	<m1hegnky2h.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 18:50:53 +0100
Message-Id: <1032371453.20463.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 18:27, Eric W. Biederman wrote:
> Plus I have played with calibrating the TSC with outb to port
> 0x80 and there was enough variation that it was unuseable.  On some
> newer systems it would take twice as long as on some older ones.

port 0x80 isnt going to PCI space.

x86 generally posts mmio write but not io write. Thats quite measurable.


