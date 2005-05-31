Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVEaJMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVEaJMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVEaJMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:12:52 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:21693 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261538AbVEaJMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:12:40 -0400
Message-ID: <429C2A64.1040204@andrew.cmu.edu>
Date: Tue, 31 May 2005 05:12:04 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au> <20050531020957.GA10814@nietzsche.lynx.com>
In-Reply-To: <20050531020957.GA10814@nietzsche.lynx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
 > Theorem proven kernels are another matter altogether, but in all
 > practicality we're very close to hard real time. Calling it soft
 > real time isn't exactly accurate too, but the thrust to get
 > theorem proven RT kernels recently has made the definitions more
 > rigid in this discussion, probably overly so. Linux will probably
 > never be submitted to any prover to do attain that. Very few,
 > (only one product of ours that I know of LynxOS 178) have taking
 > on that provability track. This is a highly competitive field.

Perhaps we should call it soft-boiled realtime?  I've always hated the 
exact hard/soft distinction too, since its something that inherently has 
two dimensions: (1) How fast does your code need to be serviced, and (2) 
how often is it acceptable for it to fail.  Even in a factory setting, a 
machine whose control system fails once every 10 years is acceptable if 
you can get better perfomance out of it.  Also, good soft realtime for 
audio can be quite a bit more difficult to implement than hard realtime 
for controlling an oil tanker.

That said, its important not to claim something about a patch which 
doesn't match the common definitions.  Ingo has been very careful in the 
claims he's made, but I think a lot of people have read his posts too 
quickly and misinterpreted what he's claiming for the current patch. 
This includes people on both sides of the fence.  He's also been silent 
for much of this discussion as its gotten out of hand, showing he's 
clearly wiser than all of us.

  - Jim Bruce
