Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWGaQEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWGaQEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWGaQEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:04:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:52914 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751229AbWGaQEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:04:38 -0400
Message-ID: <44CE2A00.4040704@zytor.com>
Date: Mon, 31 Jul 2006 09:04:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
References: <200607311541.k6VFfmKQ007278@laptop13.inf.utfsm.cl>
In-Reply-To: <200607311541.k6VFfmKQ007278@laptop13.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand wrote:
> 
>>>     instr
>> I don't recall using that variable name - I believe you mean 'intr'
>> for interrupt that I used in place of 'irq'.
> 
> Please don't. If people are accustomed to irq, they will start wondering
> what intr is all about (or what the difference is, etc).
> 

Worse, on the x86 platform, people may very well assume that irq 0 = 
intr 32 etc.

	-hpa
