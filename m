Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbTGUM5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270014AbTGUM5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:57:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:62417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269994AbTGUM53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:57:29 -0400
Date: Mon, 21 Jul 2003 06:16:34 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Ian Soboroff <ian.soboroff@nist.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 - device_suspend KERN_EMERG message?
In-Reply-To: <9cffzl0nia3.fsf@rogue.ncsl.nist.gov>
Message-ID: <Pine.LNX.4.44.0307210614260.22018-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there any special reason to scream that we're suspending devices in
> device_suspend?
> 
> int device_suspend(u32 state, u32 level)
> {
>         struct device * dev;
>         int error = 0;
> 
>         printk(KERN_EMERG "Suspending devices\n");

Hey, it's so everyone notices. :) 

I don't mind toning it down or removing it. 


	-pat

