Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265125AbSKRWGr>; Mon, 18 Nov 2002 17:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSKRWGq>; Mon, 18 Nov 2002 17:06:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29453 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265125AbSKRWGC>;
	Mon, 18 Nov 2002 17:06:02 -0500
Message-ID: <3DD965EE.5010008@pobox.com>
Date: Mon, 18 Nov 2002 17:13:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Dresser <mdresser_l@windsormachine.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
References: <Pine.LNX.4.33.0211181657310.27512-100000@router.windsormachine.com>
In-Reply-To: <Pine.LNX.4.33.0211181657310.27512-100000@router.windsormachine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grrr, Mozilla cannot seem to quote your message properly.  anyway...

Given the output you just provided, 8139too is indeed the only driver 
that will work for you.

WRT pci-skeleton.c I think that is a red herring for you... 8139cp 
support is available from 8139cp.c.  But given the lspci output, it will 
not work for you...

thanks!

	Jeff



