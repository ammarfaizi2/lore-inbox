Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbSKSSho>; Tue, 19 Nov 2002 13:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbSKSShn>; Tue, 19 Nov 2002 13:37:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267158AbSKSShm>;
	Tue, 19 Nov 2002 13:37:42 -0500
Message-ID: <3DDA8698.7050006@pobox.com>
Date: Tue, 19 Nov 2002 13:44:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Matt Reppert <arashi@arashi.yi.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] mii module broken under new scheme
References: <7FA2FEC6B51@vcnet.vc.cvut.cz>
In-Reply-To: <7FA2FEC6B51@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> I think that retrieving module name from module's binary is wrong: I
> need to have dummy.o (network driver) insmodded two times to get my
> test environment up.


agreed... this requirement is why the redundant no_module_init is needed :(


> I do not think that it is correct that I must add multiple device support
> to the dummy due to new module loader, and creating two dummy.o,
> with different .modulename sections, also does not look like reasonable
> solution to me.


The promise of minimal driver breakage is rapidly fading away.

	Jeff, still grumbling from last email message :)


