Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132400AbRDJWcN>; Tue, 10 Apr 2001 18:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132418AbRDJWcD>; Tue, 10 Apr 2001 18:32:03 -0400
Received: from smtp4.us.dell.com ([143.166.224.254]:40716 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S132400AbRDJWb5>; Tue, 10 Apr 2001 18:31:57 -0400
Date: Tue, 10 Apr 2001 17:31:55 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: <mdomsch@localhost.localdomain>
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: "David L. Nicol" <david@kasey.umkc.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Dell 4300 + megaraid
In-Reply-To: <3AD377D7.8691CD1B@kasey.umkc.edu>
Message-ID: <Pine.LNX.4.33.0104101730310.19325-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Our Dell 4300, plus raid card, works okay with a 2.2.14
> kernel, which has a version 107 megaraid.o module.  This
> is many versions behind the version present in 2.4.3.  More
> recent driver modules for the card hand on booting, thus this
> problem report.

Chances are you have downrev firmware on your PERC 2/SC card, and there
should be some messages printed on the console when the megaraid driver
tries to load, telling you to update your firmware, and hangs the system
at that point (else data corruption could ensue).

In any case, please see http://domsch.com/linux for an easy link to recent
firmware, and you should be set.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


