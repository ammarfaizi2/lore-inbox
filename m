Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWEJDU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWEJDU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWEJDU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:20:26 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:25158 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964778AbWEJDUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:20:25 -0400
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
From: Daniel Walker <dwalker@mvista.com>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
	 <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 20:20:15 -0700
Message-Id: <1147231216.21536.46.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 00:14 -0300, Matheus Izvekov wrote:
> On 5/9/06, Daniel Walker <dwalker@mvista.com> wrote:
> > unsigned long may not always be 32 bits, right ? This patch fixes the
> Incorrect, its defined as 32bits for every standard C compiler

My 64bit Athlon says it's 64bits (with gcc 3.4) .. Maybe the kernel uses
some compiler options to reduce the size .

Daniel 

