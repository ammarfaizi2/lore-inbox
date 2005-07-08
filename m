Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVGHSN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVGHSN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVGHSN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 14:13:29 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:44582 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262752AbVGHSNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 14:13:22 -0400
Message-ID: <42CEC17D.8020309@waychison.com>
Date: Fri, 08 Jul 2005 11:10:05 -0700
From: Mike Waychison <mike@waychison.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: Bryan Henderson <hbryan@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, Miklos Szeredi <miklos@szeredi.hu>,
       Pekka J Enberg <penberg@cs.helsinki.fi>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
References: <Pine.LNX.4.61.0507081527040.3743@scrub.home> <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com> <20050708180302.GC1165@wiggy.net>
In-Reply-To: <20050708180302.GC1165@wiggy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> Previously Bryan Henderson wrote:
> 
>>Two advantages of the enum declaration that haven't been mentioned yet, 
>>that help me significantly:
> 
> 
> There is another one: with enums the compiler checks types for you.
> 

enums in C are (de?)promoted to integral types under most conditions, so 
the type-checking is useless.
