Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270342AbTGWOOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270350AbTGWOOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:14:15 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:29688 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270342AbTGWOOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:14:12 -0400
Subject: Re: Feature proposal (scheduling related)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: jimis@gmx.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
References: <3F1E6A25.5030308@gmx.net>
	 <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058970206.5520.71.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 15:23:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 15:17, Valdis.Kletnieks@vt.edu wrote:
> Basically, you're stuck.  The biggest part of the problem is that although you
> can certainly control the outbound packets, you have no real control over when
> inbound packets arrive at the other end of your dial-up.  One person suggested
> using QoS to help things along - but that needs to be implemented at the OTHER
> end of the dial-up - which means unless your provider does QoS on the terminal
> server, you're basically stuck.  Packets will probably just get queued up in
> order of arrival.

There are a few things that help in the general real world but not
mathematical sense. Use an ftp client like gnome-ftp which can set the
rate it accepts data and window sizes. It'll still jam the modem a
little when it starts a transfer but then it'll generally be ok if you
have a bit of buffering for your icecast stream.

