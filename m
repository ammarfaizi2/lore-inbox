Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVASDf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVASDf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 22:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVASDf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 22:35:58 -0500
Received: from terminus.zytor.com ([209.128.68.124]:53937 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261552AbVASDfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 22:35:54 -0500
Message-ID: <41EDD584.8080307@zytor.com>
Date: Tue, 18 Jan 2005 19:35:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com> <20050118190513.GA16120@mars.ravnborg.org> <csjoef$gkt$1@terminus.zytor.com> <20050119012612.GD3867@waste.org>
In-Reply-To: <20050119012612.GD3867@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
>>
>>I would argue that "name of gcc has changed" is possibly a condition
>>that does more harm than good.  It is just as frequently used to have
>>wrappers, like distcc, as it is to have different versions.
> 
> Disagree. I switch compilers all the time and kbuild does the right
> thing for me.
> 
> I do occassionally feel your 'make install' pain and some sort of
> 'make __install' might be called for.
> 

As I said, I don't mind the default being there, it's certainly 
consistent with the default being safe.  However, not being able to 
override it is bad.

	-hpa
