Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUJVT5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUJVT5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUJVTpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:45:46 -0400
Received: from mproxy.gmail.com ([216.239.56.249]:27300 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267370AbUJVTnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:43:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=S/knCT1+CYDyySPRipklkm2KzsOf97EYmnfRo26s4fuCvm+a6pmK/jVYNLgk7fCyRkDhrPVaCJdfm19DmiKLPYnb/yV/sH1yGFOQFOfBDnJdglMVRdVGt02I8W+j9HEeuJ1Iv8lnRThVAt/oTIapCRjCE2dZrEIybhINuYHcMPY=
Message-ID: <90c25f270410221242255e3329@mail.gmail.com>
Date: Sat, 23 Oct 2004 01:12:32 +0530
From: Arvind Kalyan <base16@gmail.com>
Reply-To: Arvind Kalyan <base16@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: GPRS on Linux fails due to 255.255.255.255 remote address.
In-Reply-To: <1098469639.19435.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <90c25f2704102211212031af71@mail.gmail.com>
	 <1098469639.19435.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know how windows handles 255.255.255.255 ip addresses. When I
do ipconfig under Windows XP, I see a 255.255.255.255 as remote IP.
And also in the Properties (or status) dialog that pops up when I
double click on the blinking icon in the taskbar.

When I dial in Linux , the remote server announces itself to be
255.255.255.255 from what I see in the /var/log/messages - which I
posted to the list as well..

And about DHCP, I don't have DHCP enabled. The ppp is supposed to give
me a new IP address upon connection establishment, which is successful
(I do get a 10.* ip address each time I dial). The only thing that
doesn't seem to be working right is the thing about remote IP. It says
peer is not authorized to use 255.255.255.255 and then it quits.

There are other networking devices present in the system (ipw2100,
ethernet, ieee1394, IrDA) but I did a `/etc/init.d/network stop` to
make sure existing routes and network setup didn't affect this dialup.

If anyone needs any more information, I am willing to provide.

Thanks...



On Fri, 22 Oct 2004 19:27:20 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2004-10-22 at 19:21, Arvind Kalyan wrote:
> > c. remote IP address: 255.255.255.255
> You sure that in fact doesn't mean "pick one" to windows ?

-- 
Arvind Kalyan
