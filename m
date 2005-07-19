Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVGSRrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVGSRrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVGSRrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:47:48 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43450 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261985AbVGSRrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:47:47 -0400
Date: Tue, 19 Jul 2005 19:47:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: assignment of major number to serial driver -2.6.x kernels
In-Reply-To: <1121788393.3756.8.camel@siliver.austin.ibm.com>
Message-ID: <Pine.LNX.4.61.0507191944230.89@yvahk01.tjqt.qr>
References: <1121788393.3756.8.camel@siliver.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi All,
>
>  I would like to know whether the usage of 253 as major (device) number
>in serial port drivers is restricted in 2.6.x kernels.  I am asking this
>question, though the documentation tells the driver developers that 253
>is a reserved major number, 2.6.x Linux kernels can accommodate more
>than 255.

Majors 240 - 254 are reserved for private use, e.g. cooking@home; nothing to 
be seen in mainline drivers.
As for majors >255, you should at best try :) The dev number handling is
there - I am able to mknod blah c 1234 0.

