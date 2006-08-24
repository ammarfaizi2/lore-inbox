Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWHXQ1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWHXQ1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWHXQ1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:27:32 -0400
Received: from khc.piap.pl ([195.187.100.11]:22209 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751608AbWHXQ1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:27:32 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Serial custom speed deprecated?
References: <028a01c6c6fc$e792be90$294b82ce@stuartm>
	<1156411101.3012.15.camel@pmac.infradead.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 24 Aug 2006 18:27:29 +0200
In-Reply-To: <1156411101.3012.15.camel@pmac.infradead.org> (David Woodhouse's message of "Thu, 24 Aug 2006 10:18:21 +0100")
Message-ID: <m3bqqap09a.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

>> If custom speeds are deprecated, what's the new method for setting
>> them? Specifically, how can the SPD_CUST functionality be accomplished
>> without that flag? I've checked 2.5.64 and 2.6.17, and don't see how
>> it is possible. 
>
> We need a way to set the baud rate as an _integer_ instead of the Bxxxx
> flags.

Does that mean that standard things like termios will use:
#define B9600   9600
#define B19200 19200
?
-- 
Krzysztof Halasa
