Return-Path: <linux-kernel-owner+w=401wt.eu-S1161092AbXALLDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbXALLDD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbXALLDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:03:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2267 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161008AbXALLCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:02:46 -0500
Date: Fri, 12 Jan 2007 10:38:02 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dmitriy Monakhov <dmonakhov@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_driver resume() callback return value
Message-ID: <20070112103801.GA7145@ucw.cz>
References: <87wt3xcmyr.fsf@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wt3xcmyr.fsf@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Now question. Should we,or should we not return error code from resume callback?
> Where a two possible ways:
> a) Comment in document section is out of date and we have to properly handle 
>    and return error code if something goes wrong.

This is right.

> b) Comment in document section is correct and and dont have to worry about any 
> error, and return code  from resume() callback.
> As i understand (a) is correct answer.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Thanks for all the (sleeping) penguins.
