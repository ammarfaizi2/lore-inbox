Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSHFVAs>; Tue, 6 Aug 2002 17:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSHFU7h>; Tue, 6 Aug 2002 16:59:37 -0400
Received: from domino1.resilience.com ([209.245.157.33]:50863 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S316500AbSHFU6z>; Tue, 6 Aug 2002 16:58:55 -0400
Mime-Version: 1.0
Message-Id: <p05111a05b975e7fd2d9f@[10.128.7.49]>
In-Reply-To: <1028671263.18130.194.camel@irongate.swansea.linux.org.uk>
References: <1028660121.4771.1242.camel@flory.corp.rackablelabs.com>
 <1028671263.18130.194.camel@irongate.swansea.linux.org.uk>
Date: Tue, 6 Aug 2002 13:58:11 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: OSB4 issues on 2.4.19-ac4
Cc: linux-kernel@vger.kernel.org, Samuel Flory <sflory@rackable.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:01 PM +0100 8/6/02, Alan Cox wrote:
>On Tue, 2002-08-06 at 19:55, Samuel Flory wrote:
>>    It appears that the OSB4 ide controller isn't working on ac4.  I have
>>  a Tyan 2515, and 2518 which hang when dma is enabled.
>
>DMA enabled by you or by the driver. Right now the driver isnt supposed
>to be enabling DMA on OSB4

FWIW, we're building systems with OSB4s, and can consistently 
generate the advertised IDE corruption if we enable Ultra DMA (this 
is with RH 2.4.9-31, which has an extra OSB4 warning message; the 
message correlates with on-disk corruption).

After suffering with PIO for a month or three, we did fairly 
extensive testing with multiword DMA (non-Ultra), and are feeling 
confident enough about it to leave it turned on.
-- 
/Jonathan Lundell.
