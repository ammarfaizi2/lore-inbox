Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTDPQyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTDPQxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:53:44 -0400
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.114.72.97]:1552
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S264503AbTDPQxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:53:18 -0400
Message-ID: <005901c3043a$ccc431d0$7c07a8c0@kennet.coplanar.net>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: <steve.cameron@hp.com>, <linux-kernel@vger.kernel.org>
References: <20030416020059.GA27314@zuul.cca.cpqcorp.net>
Subject: Re: How to identify contents of /lib/modules/*
Date: Wed, 16 Apr 2003 13:08:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should definitely mention this to your distribution creator.  IMHO, it's
seriously broken if uname -r isn't distinct.  Debian is unfortunately a
victim of this; I have modded my kernel-image source package to *fix* it.  I
don't recall RedHat having this problem, but other RPM based I don't know.
Can you say what your distro is?

Cheers,

Jeremy
----- Original Message -----
From: "Stephen Cameron" <steve.cameron@hp.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, April 15, 2003 10:00 PM
Subject: How to identify contents of /lib/modules/*


>
> Hi, here's a problem I'm having, perhaps someone has some smart idea...
>
> A certain major linux distribution distributes a number of binary
> kernels, errata kernels, which all report the exact same thing
> via "uname -r".  These kernels may differ by only a little
> (only the .config file is different in some small way) or by
> a lot (binary drivers for one don't work (panic) on another).

