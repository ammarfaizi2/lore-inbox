Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVDYLkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVDYLkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVDYLkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:40:51 -0400
Received: from mx01.qsc.de ([213.148.129.14]:53423 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S262591AbVDYLks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:40:48 -0400
Message-ID: <426CD703.5040009@exactcode.de>
Date: Mon, 25 Apr 2005 13:39:47 +0200
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCode
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
CC: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
References: <426CD1F1.2010101@tiscali.de>
In-Reply-To: <426CD1F1.2010101@tiscali.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matthias-Christian Ott wrote:
> The "git" didn't try store small variables, which aren't referenced, in 
> the processor registers. It also didn't use the size_t type. I corrected 
> a C++ style comment too.

Well, modern compilers take register as a non-binding hint. Your 
register storage specification for those loop counters will not make any 
change. You have not looked into the resulting binary?

Also // is valid C99 ...

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de/ | http://www.t2-project.org/
             +49 (0)30  255 897 45

