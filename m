Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272833AbTG3Iux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272836AbTG3Iux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:50:53 -0400
Received: from [217.222.53.238] ([217.222.53.238]:49414 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S272833AbTG3Iuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:50:52 -0400
Message-ID: <3F2786E9.9010808@gts.it>
Date: Wed, 30 Jul 2003 10:50:49 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
References: <20030729182138.76ff2d96.lista1@telia.com>
In-Reply-To: <20030729182138.76ff2d96.lista1@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:

> On 2003-07-29 12:00:06 Stefano Rivoir wrote:
> 
> 
>>Is there something I'm missing?!
> 
> 
> No, you are not ;-) You can reclaim some speed by doing a "hdparm -a
> 512". See thread for explanation (it's the borked value for readahead):

Thanks for the hint. This seems to make things a little better, but I'm
still far away from 2.4 performances. I thought that anticipatory sched
could be part of the problem, and booting with elevator=deadline
does a little better... but using 2.4 is completely another thing.
By the way, -a 512 vs -a 8 is a kernel "change" or an hdpam one?

Bye

-- 
Stefano RIVOIR
GTS Srl



