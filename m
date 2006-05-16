Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWEPO7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWEPO7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWEPO7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:59:00 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:12479
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751179AbWEPO67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:58:59 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Kyle Moffett <mrmacman_g4@mac.com>,
       Johannes Berg <johannes@sipsolutions.net>
Subject: Re: /dev/random on Linux
Date: Tue, 16 May 2006 16:58:33 +0200
User-Agent: KMail/1.9.1
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com> <20060516025003.GC18645@rhun.haifa.ibm.com> <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
In-Reply-To: <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Day <imipak@yahoo.com>,
       linux-kernel@vger.kernel.org, Zvika Gutterman <zvi@safend.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605161658.33855.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 10:15, you wrote:
> >> I would dismiss 2.2 for the cases of things like Knoppix because  
> >> CDs introduce significant randomness because each time you boot  
> >> the CD is subtly differently positioned. The OpenWRT case seems  
> >> more credible.

I think most (all?) of the machines, OpenWRT runs on, are running
a bcm43xx wireless chip. This chip has a hardware random number
generator. patches to utilize it recently went into -mm.
But I must admit, we don't know how it generates random numbers.
But someone did some RNG tests on it in the past (I think it was
Johannes).
