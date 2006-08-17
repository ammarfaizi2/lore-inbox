Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWHQLJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWHQLJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHQLJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:09:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21161 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964807AbWHQLJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:09:13 -0400
Subject: Re: [PATCH] [3/3] Support piping into commands in
	/proc/sys/kernel/core_pattern
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060817094640.GA3173@muc.de>
References: <20060814127.183332000@suse.de>
	 <20060814112732.684D313BD9@wotan.suse.de>
	 <20060816084354.GF24139@kroah.com> <20060816111801.0fc5093e.ak@muc.de>
	 <20060816111025.1ab702a1.akpm@osdl.org>  <20060817094640.GA3173@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 12:27:44 +0100
Message-Id: <1155814064.15195.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 11:46 +0200, ysgrifennodd Andi Kleen:
> Several people from the embedded area wrote me privately
> it would be useful for them. Also I think once it's in the main kernel
> there will be more incentive for user space to use it and I'm optimistic
> it will get some adoption (ok I guess I should write some better
> documentation, but there was no obvious place for it)

I don't believe that piping as such as neccessarily the right model, but
the ability to intercept and processes core dumps from user space is
asked for by many enterprise users as well. They want to know about,
capture, analyse and process core dumps, often centrally and in
automated form.

Alan

