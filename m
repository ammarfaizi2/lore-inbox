Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWJFH2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWJFH2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWJFH2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:28:17 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:47787 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1161090AbWJFH2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:28:16 -0400
Date: Fri, 6 Oct 2006 09:33:03 +0200
From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
To: Witold =?utf-8?B?V8WCYWR5c8WCYXc=?= Wojciech Wilk 
	<witold.wilk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get the kernel to be more "verbose"?
Message-ID: <20061006073303.GA5105@cepheus.pub>
References: <98975a8b0610052234p3287ab8fr70335f858ba4583b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98975a8b0610052234p3287ab8fr70335f858ba4583b@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Organization: Universitaet Freiburg, Institut f. Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Witold,

Witold Władysław Wojciech Wilk wrote:
> I've tried using the /proc/config.gz provided by the default kernel,
> but to no avail.
Does this mean, you cannot find the config because /proc/config.gz
doesn't exist?  Then try /boot/config-2.6.8.  Maybe I misunderstood you?
 
> The next step of loading the kernel I have seen in various logs is the
> TCP/IP stack, am I right? 
I think offically the initcalls are in no particular order, but in
practice in depends on the linking order.  For my kernel the next line
is

	IP route cache hash table entries: 32768 (order: 5, 131072 bytes)

> Any help? Please point me at something, I am trying for two weeks
> already, and I cannot find any problems like mine. Thanks a lot for
> any help.
You can try the "initcall_debug" kernel parameter to see which init
functions are called.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=12+mol+in+dozen
