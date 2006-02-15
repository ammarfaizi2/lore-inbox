Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422872AbWBOGmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422872AbWBOGmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBOGmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:42:04 -0500
Received: from mail.majordomo.ru ([81.177.16.8]:47883 "EHLO mail.majordomo.ru")
	by vger.kernel.org with ESMTP id S1422872AbWBOGmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:42:00 -0500
Message-ID: <43F2F0E7.7080103@nndl.org>
Date: Wed, 15 Feb 2006 09:14:15 +0000
From: "Nikolay N. Ivanov" <nn@nndl.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.x - very slow disk-writing
References: <43F0F67A.8080001@nndl.org>	<20060213200517.20f7a291.akpm@osdl.org>	<43F2BEE5.5060002@nndl.org>	<20060214193121.752767ee.akpm@osdl.org>	<43F2D3A3.9030707@nndl.org> <20060214205458.10328f36.akpm@osdl.org>
In-Reply-To: <20060214205458.10328f36.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The disk isn't using DMA.
> 
> Check your IDE config settings, make sure that the right chipset support is
> turned on, that "Generic PCI bus-master DMA support" is enabled, check
> "Force enable legacy 2.0.X HOSTS to use DMA", "Use PCI DMA by default when
> available", "Enable DMA only for disks", etc.
> 
> If none of that gets it into DMA mode then we might have broken the IDE
> driver.

I've forgotten to switch on my VIA-chipset support. The problem was 
about 20 inches in front of my monitor. Sorry to troubled you.

Andrew, Lee, thanks a lot!

-- 
Nikolay N. Ivanov
mailto: nn@nndl.org
