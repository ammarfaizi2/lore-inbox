Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUJQNau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUJQNau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 09:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUJQNau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 09:30:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50157 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269117AbUJQNat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 09:30:49 -0400
Message-ID: <417273F9.6050605@pobox.com>
Date: Sun, 17 Oct 2004 09:30:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com>	<20041016171458.4511ad8b.akpm@osdl.org>	<4171C20D.1000105@pobox.com> <20041016182116.33b3b788.akpm@osdl.org> <4171E978.6060207@pobox.com> <41720740.2030901@yahoo.com.au>
In-Reply-To: <41720740.2030901@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Hi Jeff, my patch has gone to Linus... but if you have time can
> you just verify that it works without the added cond_resched()
> please?
> 
> Thanks.


Wouldn't akpm's patch be better?

I would tend to prefer that a one-liner hang fix go into -final, as it's 
easier to review and verify at this late stage.

	Jeff


