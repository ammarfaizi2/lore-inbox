Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUBQJvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 04:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUBQJvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 04:51:41 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15889 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264546AbUBQJvk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 04:51:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Carl Thompson <cet@carlthompson.net>
Subject: Re: hard lock using combination of devices
Date: Tue, 17 Feb 2004 11:49:49 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net> <200402170854.22973.vda@port.imtp.ilyichevsk.odessa.ua> <20040216231401.3ig4kksk4k8g8440@carlthompson.net>
In-Reply-To: <20040216231401.3ig4kksk4k8g8440@carlthompson.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402171149.49985.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 09:14, Carl Thompson wrote:
> Quoting vda <vda@port.imtp.ilyichevsk.odessa.ua>:
> > ...
> >
> > Your box share IRQs in a big way :)
>
> Your point?

While shared interrupts can in theory work right,
lots of hardware and/or drivers do not handle
that.

I think you should try to reconfigure your
system so that devices do not share same IRQ
and see whether that 'fix' the problem.

BTW, can you show your /proc/interrupts ?
--
vda
