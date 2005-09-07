Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVIGAJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVIGAJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 20:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVIGAJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 20:09:11 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:49826 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751160AbVIGAJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 20:09:10 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <431E2F4C.7070600@zytor.com>
Date: Tue, 06 Sep 2005 17:07:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Matz <matz@suse.de>
CC: Terrence Miller <Terrence.Miller@Sun.COM>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, Jakub Jelinek <jakub@redhat.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" -> "static
 inline"
References: <20050902203123.GT3657@stusta.de> <20050905184740.GF7403@devserv.devel.redhat.com> <431DD7BE.7060504@Sun.COM> <200509062223.50747.ak@suse.de> <431E023E.3050301@Sun.COM> <Pine.LNX.4.58.0509062332040.27439@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.58.0509062332040.27439@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Matz wrote:
> 
> As "extern inline" is a GNU extension I don't understand this remark.  

Sort of.

C99 has the equivalent construct, but spell it differently:

inline foo(int bar) {
	...
}
extern foo(int bar);

There is no "static inline" in C99 either; it's just "inline".

	-hpa
