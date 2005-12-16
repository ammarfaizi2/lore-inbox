Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVLPAH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVLPAH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVLPAH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:07:58 -0500
Received: from smtp.terra.es ([213.4.129.129]:33643 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S1751149AbVLPAH6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:07:58 -0500
Date: Fri, 16 Dec 2005 01:08:02 +0100
From: "Fri, 16 Dec 2005 01:08:02 +0100" <grundig@teleline.es>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: rlrevell@joe-job.com, bunk@stusta.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051216010802.ed7daadc.grundig@teleline.es>
In-Reply-To: <43A1E876.6050407@wolfmountaingroup.com>
References: <20051215212447.GR23349@stusta.de>
	<20051215140013.7d4ffd5b.akpm@osdl.org>
	<20051215223000.GU23349@stusta.de>
	<43A1DB18.4030307@wolfmountaingroup.com>
	<1134688488.12086.172.camel@mindpipe>
	<43A1E451.2090703@wolfmountaingroup.com>
	<1134689197.12086.176.camel@mindpipe>
	<43A1E876.6050407@wolfmountaingroup.com>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 15 Dec 2005 15:04:38 -0700,
"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:

> apply to kernel code.  calls from several of our apps (which use
> larger than 4K kernel space on a stack) from user space crash -- so do 
> wireless drivers -- and kdb crashes as well with some bugs with 4K stacks
> turned on when you are trying to debug something. 

If you (or other people) don't report those bugs, nobody else except
you will care about them, I'm afraid.

"My customer says it crashes but I don't want to report it publically".
What kind of excuse is that? O_o
