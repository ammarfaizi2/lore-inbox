Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTK1LJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 06:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTK1LJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 06:09:34 -0500
Received: from hogthrob.ic.uva.nl ([145.18.240.233]:28804 "EHLO
	hogthrob.muppets.hoogervorst.net") by vger.kernel.org with ESMTP
	id S262127AbTK1LJd convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 06:09:33 -0500
From: "J.W. Hoogervorst" <Jeroen@Hoogervorst.net>
To: <Linux-kernel@vger.kernel.org>
Subject: FW: Bug in tun driver with devfs
Date: Fri, 28 Nov 2003 12:09:31 +0100
Message-ID: <05AB1317EF6EED4DBF540147C451596B4B3D5F@oort.uva.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: root [mailto:Jeroen@Hoogervorst.net] 
Sent: Thursday, November 27, 2003 10:42 PM
To: eike-kernel@sf-tec.de
Subject: Re: Bug in tun driver with devfs


Hello,

> Are you absolutely sure that this one is made by the
kernel?
> I think this type of links is created by devfsd. Disable
devfsd
> and look if the link ist still there, if not that is a
mistake
> in your /etc/devfsd.conf

Whoops. You're right. It seems standard devfsd
/lib/dev-state setup on
my laptop was wrong. Fixed now (I misread misc.c/tun.c about
this).

Sorry for wasting your time ;-)

Regards,
Jeroen


