Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFJW7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTFJW7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:59:14 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:32912 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261797AbTFJW7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:59:12 -0400
Subject: Re: 2.5.70-mm7
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1055286765.2371.4.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jun 2003 19:12:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am Die, 2003-06-10 um 22.00 schrieb Konstantin Kletschke: 


> Well, is the device-mapper module dm-mod not komptaibel anymore with
my
> device-mapper 0.96.08 ?
> I did not get it to mount the LVM LVGs and device-mapper was very
angry!
> But I am not able to get the error message ATM, something with
"function
> not supportet, 2 " or so...


	I got the same here. Backed out the device-mapper patches Joe 	Thornber
posted here, and now it works. 


	It looks like a problem with the cleanups, at least I didn't see 	any
ioctl interface change? 


Yeah, I got the same. The message is something like 
"ioctl cmd 2 No such address or device".

Joe, do we need to upgrade some tools or something here?

Regards,

Shane


