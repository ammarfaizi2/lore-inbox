Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUKWWQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUKWWQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKWWOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:14:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36518 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261505AbUKWWLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:11:41 -0500
Date: Tue, 23 Nov 2004 23:11:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: description of struct sockaddr
In-Reply-To: <20041123214300.GB2147@beton.cybernet.src>
Message-ID: <Pine.LNX.4.53.0411232309360.23119@yvahk01.tjqt.qr>
References: <20041123214300.GB2147@beton.cybernet.src>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello
>
>man netdevice talks about struct sockaddr, but neither describes it,
>nor provides a link to descriptio, nor the "SEE ALSO" items
>(ip(7), proc(7), rnetlink(7)) provide the necessary information.
>
>"The hardware address is specified in a struct sockaddr".

I don't think so. The hardware address is, well, specific to the hardware (like
Ethernet, for example). IP/TCP/UDP however is not limited to Ethernet. And
'sockaddr' clearly is something that does not deal with hardware.

>Where is struct sockaddr specified?

Somewhere in the depths of /usr/include and your linux kernel tree.
Oh yeah, be warned, glibc is a #define hell when you're looking for sockaddr
stuff.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
