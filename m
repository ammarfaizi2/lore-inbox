Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbTGCRZC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTGCRZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:25:02 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:42393 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265074AbTGCRYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:24:52 -0400
Message-ID: <3F046A30.6080509@nortelnetworks.com>
Date: Thu, 03 Jul 2003 13:38:56 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>			<3F0411B9.9E11022D@pp.inet.fi> <20030703082034.5643b336.akpm@osdl.org> <3F04680D.B9703696@pp.inet.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:

> Because loop-AES attempts to be compatible with structures in loop.h by not
> modifying loop.h at all. This is what the "no kernel sources patched or
> replaced" means. Breakage in loop.h breaks loop-AES, and I have to clean the
> mess.

We're in a development stream.  It is kind of expected that in-kernel 
APIs may change if the developers feel it will lead to some improvement.

This sucks for people that are trying to track those APIs with 
out-of-kernel patches, but its a fact of life.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

