Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269312AbUJEQaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269312AbUJEQaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270127AbUJEQAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:00:32 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:8122 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S270098AbUJEP71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:59:27 -0400
Message-ID: <4162C474.8010505@rtr.ca>
Date: Tue, 05 Oct 2004 11:57:40 -0400
From: Mark Lord <lsml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Oliver Neukum <oliver@neukum.org>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Core scsi layer crashes in 2.6.8.1
References: <1096401785.13936.5.camel@localhost.localdomain>	<4162B345.9000806@rtr.ca> <1096988167.2064.7.camel@mulgrave> 	<200410051749.22245.oliver@neukum.org> <1096991666.2064.25.camel@mulgrave>
In-Reply-To: <1096991666.2064.25.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>
> It would add quite a bit of complexity to the reference counted
> aynchronous model to try and force synchronicity between queuecommand
> and scsi_remove_host in the mid-layer.  Therefore it's much easier to
> let the LLD decide what to do with the command.

Presumably the same is also true for scsi_remove_device() ?

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
