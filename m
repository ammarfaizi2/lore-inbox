Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270975AbTGPRxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270994AbTGPRxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:53:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:15331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270975AbTGPRwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:52:43 -0400
Date: Wed, 16 Jul 2003 11:00:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: axboe@suse.de, davej@codemonkey.org.uk, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-Id: <20030716110009.43129dca.akpm@osdl.org>
In-Reply-To: <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
References: <20030716165701.GA21896@suse.de>
	<20030716170352.GJ833@suse.de>
	<1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> > SG_IO, that way you can use dma (and zero copy) for the rips. That will
> > be lots more smooth.
> 
> So why isnt this occuring on 2.4 .. thats the important question here is
> this a logging thing, a new input layer bug, an ide bug or what ?

input layer, I think.  Several people are having problems with the
synchronisation loss thing.

