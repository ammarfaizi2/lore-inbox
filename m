Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272199AbRHWDMY>; Wed, 22 Aug 2001 23:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272198AbRHWDMO>; Wed, 22 Aug 2001 23:12:14 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:13331 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272199AbRHWDMD>; Wed, 22 Aug 2001 23:12:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Brad Chapman <kakadu_croc@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 VM/VMA subsystem works much better
Date: Thu, 23 Aug 2001 05:18:29 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010822195810.75425.qmail@web10902.mail.yahoo.com>
In-Reply-To: <20010822195810.75425.qmail@web10902.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010823031202Z16066-32383+935@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 22, 2001 09:58 pm, Brad Chapman wrote:
> Everyone,
> 
> 	Just a note: the VMA sanity patch which went in to 2.4.9
> has improved Mozilla's performance considerably. I did a rough
> calculation based on startup time and found that Mozilla started
> approximately 10%-12% faster on 2.4.9 then 2.4.8. Plus, I've
> found that swapping is actually starting to work again, although
> it still tends to stick at certain times.
> 
> 	Great job everyone.

Make sure you have my SetPageReferenced patch in, swap is borked without 
it.

--
Daniel
