Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTFDMgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTFDMgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:36:19 -0400
Received: from [151.17.201.167] ([151.17.201.167]:46091 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id S263277AbTFDMgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:36:18 -0400
Message-ID: <3EDDE8F6.10506@teamfab.it>
Date: Wed, 04 Jun 2003 14:41:26 +0200
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
Organization: TeamSystem Spa
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.3.1) Gecko/20030519
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: partition table problem with 2.4.21-rc7
References: <87brxemtev.fsf@mcs.anl.gov>  <3EDD9E5C.9060902@teamfab.it> <1054722814.9359.95.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1054722814.9359.95.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox ha scritto:

> 
> That would make sense. The drive is attached to the null driver at
> the point something tried to read the partition table initially. That
> errors all I/O requests since they are meaningless.
> 
> I guess we shouldnt be partition probing those devices. I'll take a
> look

Cool,
feel free to test any patch from you

luca


