Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTA0QoS>; Mon, 27 Jan 2003 11:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTA0QoS>; Mon, 27 Jan 2003 11:44:18 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:50750 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267235AbTA0QoR>; Mon, 27 Jan 2003 11:44:17 -0500
Message-ID: <3E356403.9010805@google.com>
Date: Mon, 27 Jan 2003 08:53:23 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3 kernel crash
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like the same problem I ran into with IDE and highmem not 
getting along.  Try compiling your kernel with out highmem enabled and 
see what happenes.

    Ross

Martin MOKREJ© wrote:

>  
>
>
>Trace; c024dfc1 <ide_build_sglist+181/1a0>
>Trace; c024e1b4 <ide_build_dmatable+54/1a0>
>Trace; c024e6df <__ide_dma_read+3f/150>
>
>  
>


