Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVIMPae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVIMPae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbVIMPad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:30:33 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:10250 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S932675AbVIMPad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:30:33 -0400
Message-ID: <4326F093.80206@rulez.cz>
Date: Tue, 13 Sep 2005 17:30:27 +0200
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: query_modules syscall gone? Any replacement?
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz> <4326DE0E.2060306@rulez.cz> <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net>
In-Reply-To: <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nope, they are not prevented.  However, there is a Tainted flag
> that is set when one is loaded (and that flag is never cleared).
> 

Okay, I've been wrong in my conclusion and I gotta read some fine manual 
about how the modules actually work -- could you recommend me some in 
particular?

>>  - /proc/modules and /sys/module interface doesn't by far supply what
>>query_module could do
> 
> Can you state succinctly exactly what you are trying to do?

I would like to be able to query symbols of a loaded module, get list of 
and list of dependencies of loaded module from an app, preferably 
without having to parse a file...
