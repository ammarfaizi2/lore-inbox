Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUJQDKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUJQDKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUJQDKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:10:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37832 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269018AbUJQDKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:10:18 -0400
Message-ID: <4171E28D.1030805@pobox.com>
Date: Sat, 16 Oct 2004 23:10:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org> <4171C20D.1000105@pobox.com> <4171C9CD.4000303@yahoo.com.au> <4171D5F8.8050504@pobox.com> <4171D6A0.4030200@yahoo.com.au> <4171D982.10605@yahoo.com.au>
In-Reply-To: <4171D982.10605@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another thing that's been bugging me...

Is the variable 'all_zones_ok' initialized in all pertinent paths?  I'm 
too slack to check, but I worry, since the variable moved up one scope 
level.

	Jeff



