Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWEJDbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWEJDbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWEJDbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:31:45 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:1356 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964783AbWEJDbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:31:44 -0400
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
From: Daniel Walker <dwalker@mvista.com>
To: Olof Johansson <olof@lixom.net>
Cc: Matheus Izvekov <mizvekov@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060510032912.GC1794@lixom.net>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
	 <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
	 <20060510032912.GC1794@lixom.net>
Content-Type: text/plain
Date: Tue, 09 May 2006 20:31:40 -0700
Message-Id: <1147231901.21536.47.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 22:29 -0500, Olof Johansson wrote:
> On Wed, May 10, 2006 at 12:14:45AM -0300, Matheus Izvekov wrote:
> > On 5/9/06, Daniel Walker <dwalker@mvista.com> wrote:
> > >unsigned long may not always be 32 bits, right ? This patch fixes the
> > Incorrect, its defined as 32bits for every standard C compiler
> 
> Wrong. The only environment I'm aware of that has only P64 is Win64.
> 
> Still, that's a bad patch, since it removes the warning without fixing
> the bug. It's a valid warning, the underlying problem should be fixed
> instead. It's better to keep the warning around until that's been done.

I never claimed to fix it ..

Daniel

