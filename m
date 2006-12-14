Return-Path: <linux-kernel-owner+w=401wt.eu-S932749AbWLNO6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbWLNO6X (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWLNO6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:58:23 -0500
Received: from ultra1.univ-paris12.fr ([193.51.100.100]:55757 "EHLO
	ultra1.univ-paris12.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749AbWLNO6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:58:21 -0500
Message-ID: <458165F3.90002@univ-paris12.fr>
Date: Thu, 14 Dec 2006 15:55:47 +0100
From: Franck Pommereau <pommereau@univ-paris12.fr>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.keel.org
Subject: Re: Executability of the stack
References: <458118BB.5050308@univ-paris12.fr>	 <1166090244.27217.978.camel@laptopd505.fenrus.org>	 <45814544.1050102@superbug.co.uk> <1166099950.27217.1024.camel@laptopd505.fenrus.org>
In-Reply-To: <1166099950.27217.1024.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> Why not show both.
>> "intent" and "effective".
> 
> that would change the file format .. which is used by apps today already
> (including glibc)

So, what about having another file, say /proc/self/emaps (effective
maps) that would display how things are really set.

Currently, is there any solution to test for effective permission except
 by trying to execute something on the stack (thus crashing the program
on a successful test...)?

Arjan van de Ven also wrote in other mails:
> the "nx" shows that if you configure your kernel correctly (enable
> PAE) that you indeed have a non-executable capability, which will
> apply to the stack (and afaik the heap too)
[...]
> enable
> CONFIG_HIGHMEM64G=y
> and you're all set
[...]
> btw in case you didn't realize this; your processor is also 64 it
> capable, just use any x86-64 distribution on it ;)

Thanks for the tips!

Franck

