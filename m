Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268330AbSIRUef>; Wed, 18 Sep 2002 16:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268344AbSIRUef>; Wed, 18 Sep 2002 16:34:35 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:31982
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268330AbSIRUed>; Wed, 18 Sep 2002 16:34:33 -0400
Subject: Re: Info: NAPI performance at "low" loads
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: ebiederm@xmission.com, hadi@cyberus.ca, akpm@digeo.com,
       manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020918.132334.102949210.davem@redhat.com>
References: <Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca>
	<20020917.180014.07882539.davem@redhat.com>
	<m1hegnky2h.fsf@frodo.biederman.org> 
	<20020918.132334.102949210.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 21:43:09 +0100
Message-Id: <1032381789.20498.151.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 21:23, David S. Miller wrote:
> The x86 processor has a well defined timing for executing inb
> etc. instructions, the timing is fixed and is independant of the
> speed of the PCI bus the device is on.

Earth calling Dave Miller

The inb timing depends on the PCI bus. If you want proof set a Matrox
G400 into no pci retry mode, run a large X load at it and time some inbs
you should be able to get to about 100 milliseconds for an inb to
execute

