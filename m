Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbREWOdF>; Wed, 23 May 2001 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263103AbREWOcz>; Wed, 23 May 2001 10:32:55 -0400
Received: from [195.6.125.97] ([195.6.125.97]:32006 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S263099AbREWOcp>;
	Wed, 23 May 2001 10:32:45 -0400
Date: Wed, 23 May 2001 16:28:01 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: [timer] max timeout
Message-Id: <20010523162801.38dabdff.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there a max timeout to respect when I use mod_timer ? or add_timer ?

Is it bad to do the following call ?

	mod_timer(&timer, jiffies+(0.1*HZ));

that might fire the timer 1/10 second later.

Thanks.

sebastien person
