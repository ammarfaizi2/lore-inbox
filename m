Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132819AbRDPAuk>; Sun, 15 Apr 2001 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132820AbRDPAu3>; Sun, 15 Apr 2001 20:50:29 -0400
Received: from [24.70.141.118] ([24.70.141.118]:33774 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S132819AbRDPAuO>;
	Sun, 15 Apr 2001 20:50:14 -0400
Date: Sun, 15 Apr 2001 20:50:11 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: David Findlay <david_j_findlay@yahoo.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <01041708461209.00352@workshop>
Message-ID: <Pine.LNX.4.33.0104152048250.17111-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, David Findlay wrote:

>> Perhaps I misunderstand what it is exactly you are trying to do,
>> but I would think that this could be done entirely in userland by
>> software that just adds rules for you instead of you having to do
>> it manually.
>
>I suppose, but it would be so much easier if the kernel did it automatically.
>Having a rule to go through for each IP address to be logged would be slower
>than implementing one rule that would log all of them. Doing this in the
>kernel would improve preformance.

I don't think it would, but then only benchmarking it both ways
would know for sure.  Even with incredibly large rulesets,
ipchains &&/|| netfilter works admirably well.  Rusty?


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

