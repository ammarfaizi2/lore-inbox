Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUISI1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUISI1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 04:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269196AbUISI1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 04:27:42 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:57538 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269190AbUISI1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 04:27:40 -0400
Message-ID: <414D42F6.5010609@softhome.net>
Date: Sun, 19 Sep 2004 10:27:34 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston>
In-Reply-To: <1095568704.6545.17.camel@gaston>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> Nope, Greg is right. Drivers themselves won't necessarily provide
> you with the device interface in a synchronous way after they are
> loaded, and some will certainly never. It is all an asynchronous process
> and there is simply no way to ask for any kind of enforced synchronicity
> here without major bloatage.
> 

   Okay, okay. Let's spread delays and polling all over numerous init 
scripts.

   You might be ten thousands time right. It is asynchronous process.

   But please listen to me: you are not going to handle that in _every_ 
system application which deals with modules.

   If there is problem, it doesn't mean we just pass it over. Probably 
we need to solve it?
