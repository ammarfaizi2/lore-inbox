Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264917AbRFZNGz>; Tue, 26 Jun 2001 09:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbRFZNGp>; Tue, 26 Jun 2001 09:06:45 -0400
Received: from wks122.navicsys.com ([207.180.73.122]:19204 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S264917AbRFZNGg>;
	Tue, 26 Jun 2001 09:06:36 -0400
To: Julien Laganier <Julien.Laganier@Sun.COM>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fork vs GDB
In-Reply-To: <3B375A77.C59A516D@Sun.COM>
From: Nick Papadonis <npapadon@yahoo.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 26 Jun 2001 09:03:23 -0400
In-Reply-To: <3B375A77.C59A516D@Sun.COM> (Julien Laganier's message of "Mon, 25 Jun 2001 17:36:23 +0200")
Message-ID: <m3ae2vz944.fsf@yahoo.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Laganier <Julien.Laganier@Sun.COM> writes:

> Greetings,
> 
> Does anyone knows how to debug a program which fork. It seems that gdb
> doesn't allow us to debug the child processes without calling 'sleep' in
> the child, and attach it to gdb (Except on HP-UX, but I choose to use
> Linux ;-)) ?
> 
> Tnx. 

Julien,

I had this question awhile back.  Your solution with sleep is the only
option, unless you wish to add support for another method.

- N
