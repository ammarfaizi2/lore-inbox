Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbSJJDPj>; Wed, 9 Oct 2002 23:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbSJJDPj>; Wed, 9 Oct 2002 23:15:39 -0400
Received: from relay1.pair.com ([209.68.1.20]:15365 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S262977AbSJJDPj>;
	Wed, 9 Oct 2002 23:15:39 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DA4F4C6.7B3FEF57@kegel.com>
Date: Wed, 09 Oct 2002 20:32:22 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <200210100355.WAA06063@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> 
> dank@kegel.com said:
> > George's approach would work a lot better when doing lots of UML VM's
> > on a single box, too, wouldn't it?
> 
> My thinking on this is that I'll have UML do the on-demand ticks. ...
> any generic support for on-demand
> ticks would be re-used by UML.  And if UML required generic changes for this,
> then that would obviously affect the other ports somehow.

Yes, exactly.  UML wants on-demand ticks, which is exactly what George's
patch
uses, too.  I'm too far from the code to say, but there ought to be some
commonality there.
- Dan
