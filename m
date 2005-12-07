Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVLGMsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVLGMsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVLGMsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:48:23 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:64865 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751021AbVLGMsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:48:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pqQJOIKzVrWD7qdk3l6PsnA+d1XH+iUDCf7PP/yyijK/ZYFs6YWNTw1LLoyGAAb782HOkMVMHMBdQYnGgE4t0svT2R0xiQ8Q8eha7rqHF88dotFJRccWhMtrMtGPuZSOx29+LwCjgYL29ww6rbQu+HjQuRWNinScvUfYBu5VPdE=
Message-ID: <4396DA09.8040800@gmail.com>
Date: Wed, 07 Dec 2005 21:48:09 +0900
From: Tejun <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1 sata_sil regression
References: <4396CB79.5040408@bootc.net>
In-Reply-To: <4396CB79.5040408@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Hi all,
> 
> I just upgraded to 2.6.15-rc5-mm1 from 2.6.15-rc2-mm1 and sata_sil 
> refused to recognise the two SATA drives that are connected to it:
> 

The sata_sil driver in the current ALL branch doesn't work due to the 
collision between pio changes and sata_sil irq handling improvements.

Jeff, maybe the sil branch shouldn't be merged into ALL for the time being?

-- 
tejun
