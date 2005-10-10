Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVJJOyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVJJOyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVJJOyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:54:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:53661 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750727AbVJJOyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:54:12 -0400
Message-ID: <434A8082.9060202@zytor.com>
Date: Mon, 10 Oct 2005 07:53:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Georg Lippold <georg.lippold@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>	 <20050831215757.GA10804@taniwha.stupidest.org>	 <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com>	 <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com>	 <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de> <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
In-Reply-To: <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> 
> Would it make sense to make it 1024 everywhere (and maybe move it out
> of arch specific files and just set it in one central place) ?
> 

I would agree with that, *BUT* the boot protocol on each architecture 
need to be consistent.

At the very least, though, i386 and x86-64 need to be changed together, 
since they use the same bootstrap.

	-hpa
