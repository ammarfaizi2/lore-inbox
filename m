Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUBNUdK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 15:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbUBNUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 15:33:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263205AbUBNUc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 15:32:59 -0500
Message-ID: <402E85EE.70801@pobox.com>
Date: Sat, 14 Feb 2004 15:32:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [BK PATCHES] 2.6.x libata update
References: <20040213184316.GA28871@gtf.org>	 <1076700491.22542.38.camel@nosferatu.lan>  <402D3B97.70005@pobox.com> <1076783378.27648.3.camel@nosferatu.lan>
In-Reply-To: <1076783378.27648.3.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> Yep, it still breaks it.  I get a dma timeout on heavy disk access,
> and then things start to freeze (or do not start at all).  Seems
> Jon is hitting the same issue with -bk4.

Thanks for re-verifying.  The buggy patch is now reverted upstream, and 
I'll be looking into another way to fix the "too many interrupts on 
ICH5" problem.

	Jeff



