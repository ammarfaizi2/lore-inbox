Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbVLFUKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVLFUKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbVLFUKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:10:21 -0500
Received: from quark.didntduck.org ([69.55.226.66]:20641 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932629AbVLFUKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:10:19 -0500
Message-ID: <4395F097.5060005@didntduck.org>
Date: Tue, 06 Dec 2005 15:12:07 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Add tainting for proprietary helper modules.
References: <20051203004102.GA2923@redhat.com>	 <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>	 <20051205173041.GE12664@redhat.com>	 <20051205093436.44d146e6@localhost.localdomain> <1133899612.23610.59.camel@localhost.localdomain>
In-Reply-To: <1133899612.23610.59.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-12-05 at 09:34 -0800, Stephen Hemminger wrote:
> 
>>IMHO ndiswrapper can't claim legitimately to be GPL, so just
>>patch that. 
> 
> 
> Actually it isnt so simple. Load ndiswrapper. Now load a GPL windows
> driver binary. I don't know if ndiswrapper itself could dig licenses out
> of windows modules but if so it could even conditionally taint.
> 
> Alan

On the other hand, if the windows driver were GPL then there wouldn't be 
any barrier to writing a native driver.

--
				Brian Gerst
