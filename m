Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTJPXIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTJPXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:08:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263280AbTJPXIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:08:19 -0400
Message-ID: <3F8F24CE.3030505@pobox.com>
Date: Thu, 16 Oct 2003 19:07:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eli Billauer <eli_billauer@users.sf.net>
CC: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016173135.GL5725@waste.org> <3F8F23BE.7020703@users.sf.net>
In-Reply-To: <3F8F23BE.7020703@users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Billauer wrote:
> If a hardware device driver is buggy, you usually know about it sooner 
> or later. If an RNG has a rare bug, or an architecture-dependent flaw, 
> it's much harder to notice. If the RNG starts to repeat itself, you 
> won't know about it, unless you happened to test exactly that data. The 
> algorithm may be perfect, but a silly bug can blow it all.


rngd tests for this :)

