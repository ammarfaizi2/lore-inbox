Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVAQWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVAQWaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVAQWZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:25:11 -0500
Received: from terminus.zytor.com ([209.128.68.124]:21725 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262903AbVAQWEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:04:41 -0500
Message-ID: <41EC363D.1090106@zytor.com>
Date: Mon, 17 Jan 2005 14:03:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org>
In-Reply-To: <20050117220052.GB18293@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> It better be difficult. You want to recompile when changing gcc.
> Try this untested patch.
> 

Sorry, but that's baloney.  Saying "it better be difficult" is 
equivalent to saying "kbuild is smarter than you."

I don't mind the current default, but saying I shouldn't be able to 
override it is asinine.

It also means "make install" is largely unusable.

> There is no way to tell kbuild "ignore gcc change"

There really needs to be one.

	-hpa
