Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUIWXh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUIWXh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUIWXfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:35:46 -0400
Received: from [209.195.52.120] ([209.195.52.120]:23685 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S267545AbUIWXbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:31:39 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 23 Sep 2004 16:31:35 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: max file handles max
In-Reply-To: <1095976607.7277.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0409231628070.32471@dlang.diginsite.com>
References: <200409222357.39492.tabris@tabris.net><200409231314.55547.bzolnier@elka.pw.edu.pl><200409231630.49153.tabris@tabris.net>
 <1095976607.7277.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some boxes that have been hitting max file handles when other 
systems around them misbehave. I've set the max file handles up to 32k, 
but I'm wondering how high this can really go beofre running into 
problems?

I saw the discussion recently about problems when you have more then 32K 
processes and so far I'm not hitting that, but I do want to raise all the 
other limits up to the point where they are all hit at about the same time 
(for file handles it looks like it's currently useing ~4-5 per process so 
I would be talking 128k+ file-max.

David Lang
