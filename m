Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSKRP23>; Mon, 18 Nov 2002 10:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSKRP23>; Mon, 18 Nov 2002 10:28:29 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:30109 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261613AbSKRP22>; Mon, 18 Nov 2002 10:28:28 -0500
Message-ID: <3DD908AB.8040102@nortelnetworks.com>
Date: Mon, 18 Nov 2002 10:35:07 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Panos <epp719@aretousa.epp.teiher.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.19 + poweroff
References: <Pine.LNX.4.44.0211181716220.30592-100000@aretousa.epp.teiher.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panos wrote:
i have compiled the kernel 2.4.19 and when i
> shutdown the pc using halt it doesnt poweroff. i tried either with apm 
> builtin and module but nothing happened.

I had to make sure that ACPI power management was not enabled in any 
form, since it overrides APM but the userspace didn't understand it.


Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

