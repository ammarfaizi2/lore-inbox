Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270968AbTGPRAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270971AbTGPQ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:59:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16075
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270968AbTGPQ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:58:26 -0400
Subject: Re: PS2 mouse going nuts during cdparanoia session.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@codemonkey.org.uk>, vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716170352.GJ833@suse.de>
References: <20030716165701.GA21896@suse.de>  <20030716170352.GJ833@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 18:10:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 18:03, Jens Axboe wrote:
> > The IDE CD drive is using DMA, and interrupts are unmasked.
> > according to the logs, its happened 32 times since I last

> Yes. You can try and make the situation a little better by unmasking
> interrupts with -u1. Or you can try and use a ripper that actually uses

He already is 

> SG_IO, that way you can use dma (and zero copy) for the rips. That will
> be lots more smooth.

So why isnt this occuring on 2.4 .. thats the important question here is
this a logging thing, a new input layer bug, an ide bug or what ?

