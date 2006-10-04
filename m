Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWJDHTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWJDHTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWJDHTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:19:43 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:37558 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161106AbWJDHTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:19:42 -0400
Date: Wed, 4 Oct 2006 09:14:19 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>,
       <linux-kernel@vger.kernel.org>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
Message-ID: <20061004091419.455f4185@localhost>
In-Reply-To: <Pine.LNX.4.44L0.0610031629310.5817-100000@iolanthe.rowland.org>
References: <20061003215200.0d1047db@localhost>
	<Pine.LNX.4.44L0.0610031629310.5817-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 16:34:51 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> I wonder whether the code in question was supposed to be running at all.  
> Arkadiusz, what sort of USB devices do you have attached to the computer?

He of course has an ADSL USB modem (sice he uses uEagle-ATM driver)...

So one obvious test that Arkadiusz can make is to try to crash 2.6.18
without using his modem: just detach the USB cable before boot so the
driver isn't loaded (and even if it's loaded by a "modprobe" in
init scripts, it can't do much).

-- 
	Paolo Ornati
	Linux 2.6.18 on x86_64
