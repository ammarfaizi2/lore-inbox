Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbTC1WYs>; Fri, 28 Mar 2003 17:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263178AbTC1WYs>; Fri, 28 Mar 2003 17:24:48 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24737 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S263177AbTC1WYq>; Fri, 28 Mar 2003 17:24:46 -0500
Message-ID: <3E84CE29.8070806@nortelnetworks.com>
Date: Fri, 28 Mar 2003 17:35:21 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: some 2.5.66 issues
References: <1048893853.1314.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje wrote:

> Now, something more problematic. I'm being told to use try_module_get()
> instead of MOD_INC_USE_COUNT. Cool. Somehow, it returns 1. I had a look
> at the code in linux/module.h and am a bit confused:

> Why does it only return 0 if the module is not alive? This sounds...
> er... weird? Can someone please enlighten me?

Presumably so you can treat the result as a boolean true/false value.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

