Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVASEoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVASEoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 23:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVASEop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:44:45 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:55721 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261562AbVASEon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:44:43 -0500
In-Reply-To: <41EDD584.8080307@zytor.com>
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com> <20050118190513.GA16120@mars.ravnborg.org> <csjoef$gkt$1@terminus.zytor.com> <20050119012612.GD3867@waste.org> <41EDD584.8080307@zytor.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7B42B92D-69D4-11D9-88A5-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: kbuild: Implicit dependence on the C compiler
Date: Wed, 19 Jan 2005 05:42:10 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-01-19, at 04:35, H. Peter Anvin wrote:

> Matt Mackall wrote:
>>>
>>> I would argue that "name of gcc has changed" is possibly a condition
>>> that does more harm than good.  It is just as frequently used to have
>>> wrappers, like distcc, as it is to have different versions.
>> Disagree. I switch compilers all the time and kbuild does the right
>> thing for me.
>> I do occassionally feel your 'make install' pain and some sort of
>> 'make __install' might be called for.
>
> As I said, I don't mind the default being there, it's certainly 
> consistent with the default being safe.  However, not being able to 
> override it is bad.

Just please consider

CC ?= gcc

instead of

CC = gcc

in Makefiles. I assume it does precisely what you want. So I think 
anybody arguing against
you is just arguing about a single ASCII character...

